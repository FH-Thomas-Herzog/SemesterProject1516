using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Exception;
using UFO.Commander.Service.Api.Properties;
using UFO.Commander.Service.Impl.Base;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;

namespace UFO.Commander.Service.Impl
{
    public class PerformanceService : BaseService, IPerformanceService
    {
        IPerformanceDao performanceDao;
        IArtistDao artistDao;
        IVenueDao venueDao;

        public PerformanceService(DbConnection connection) : base(connection)
        {
            performanceDao = DaoFactory.CreatePerformanceDao(Connection);
            artistDao = DaoFactory.CreateArtistDao(Connection);
            venueDao = DaoFactory.CreateVenueDao(Connection);
        }

        public void Delete(long? id)
        {
            if (id == null)
            {
                throw new ArgumentException("Cannot delete performance with nul id");
            }
            try
            {
                StartTx();
                Performance performance = performanceDao.ById(id);
                // Performance has already been started
                if (performance.StartDate.Value.CompareTo(DateTime.Now) <= 0)
                {
                    throw new ServiceException((int)PerformanceErrorCode.PERFORMANCE_ALREADY_STARTED);
                }
                performanceDao.Delete(id);
                CommitTx();
            }
            catch (Exception e)
            {
                RollbackTx();
                throw e;
            }

        }
        public Performance Save(Performance performance, int hourOffset = 0)
        {
            if (performance == null)
            {
                throw new ArgumentException("Cannot save null perforamnce");
            }
            try
            {
                StartTx();
                Performance performanceDB = null;
                Artist artist = artistDao.ById(performance.ArtistId);
                venueDao.EntityExists(performance.VenueId);

                // Validate start end dates
                if (performance.StartDate.Value.Date != performance.EndDate.Value.Date)
                {
                    throw new ServiceException((int)PerformanceErrorCode.PERFORMANCE_DATE_INVALID);
                }
                if ((performance.StartDate.Value.Hour + 1) != (performance.EndDate.Value.Hour))
                {
                    throw new ServiceException((int)PerformanceErrorCode.PERFORMANCE_DATE_INVALID);
                }

                // Clear eventually added millis and seconds
                performance.StartDate = new DateTime(
                    performance.StartDate.Value.Year,
                    performance.StartDate.Value.Month,
                    performance.StartDate.Value.Day,
                    performance.StartDate.Value.Hour,
                    0,
                    0);
                performance.EndDate = new DateTime(
                    performance.EndDate.Value.Year,
                    performance.EndDate.Value.Month,
                    performance.EndDate.Value.Day,
                    performance.EndDate.Value.Hour,
                    0,
                    0);

                // Validate if artist has already a performance with the defined date + offset
                DateTime startDateWithOffset = performance.StartDate.Value;
                DateTime endDateWithOffset = performance.EndDate.Value;
                startDateWithOffset = startDateWithOffset.AddHours(-hourOffset);
                endDateWithOffset = endDateWithOffset.AddHours(hourOffset);
                if (performanceDao.ArtistHasPerformanceOnDate(performance.ArtistId, startDateWithOffset, endDateWithOffset, performance.Id ?? -1))
                {
                    throw new ServiceException((int)PerformanceErrorCode.ARTIST_OVERBOOKED);
                }

                // Validate if other artist has performance on venue
                if (performanceDao.VenueHasPerformanceOnDate(performance.VenueId.Value, performance.StartDate.Value, performance.EndDate.Value, performance.Id ?? -1))
                {
                    throw new ServiceException((int)PerformanceErrorCode.VENUE_OVERBOOKED);
                }

                // New performance
                if (performance.Id == null)
                {
                    performanceDB = performanceDao.Persist(performance);
                }
                // Update existing one
                else
                {
                    // Check if performance is moved and save former dateTime values if it is so
                    performanceDB = performanceDao.ById(performance.Id);
                    if (performanceDB.StartDate.Value.CompareTo(performance.StartDate.Value) != 0)
                    {
                        performance.FormerStartDate = performanceDB.StartDate;
                        performance.FormerEndDate = performanceDB.EndDate;
                    }
                    // Check if venue has changed
                    if (performanceDB.VenueId != performance.VenueId)
                    {
                        performance.FormerVenueId = performanceDB.VenueId;
                    }

                    performanceDB = performanceDao.Update(performance);
                }
                CommitTx();
                return performanceDB;
            }
            catch (Exception)
            {
                RollbackTx();
                throw;
            }
        }

        public int Notify(string subject, string content)
        {
            int count = 0;
            IDictionary<Artist, IList<Performance>> map = performanceDao.GetAllPerformancesForNotification();
            SmtpClient client;
            try
            {
                client = new SmtpClient();
            }
            catch (Exception e)
            {
                throw new ServiceException((int)PerformanceErrorCode.NOTIFICATION_ERROR, "SMTP Client could not be created", e);
            }
            CultureInfo originalCulture = Thread.CurrentThread.CurrentCulture;

            try
            {
                foreach (var artist in map)
                {
                    StringBuilder sb = new StringBuilder(content).Append(System.Environment.NewLine);
                    DateTime? date = null;
                    CultureInfo artistCulture = new CultureInfo(artist.Key.CountryCode);
                    Thread.CurrentThread.CurrentCulture = artistCulture;
                    foreach (var performance in artist.Value)
                    {
                        if ((date == null) || (date.Value.Date.CompareTo(performance.StartDate.Value.Date) != 0))
                        {
                            date = performance.StartDate.Value.Date;
                            sb.Append(System.Environment.NewLine).Append(date.Value.ToShortDateString()).Append(":").Append(Environment.NewLine);
                        }
                        sb.Append(performance.Venue.Name).Append(", ")
                          .Append(performance.StartDate.Value.ToShortTimeString()).Append(" - ").Append(performance.EndDate.Value.ToShortTimeString()).Append(Environment.NewLine);
                    }
                    try
                    {
                        MailMessage mail = new MailMessage
                        {
                            To = { new MailAddress(artist.Key.Email) },
                            Subject = subject,
                            Body = sb.ToString()
                        };
                        client.Send(mail);
                        count++;
                    }
                    catch (Exception e)
                    {
                        // Do nothing if one mail fails
                    }
                }
                return count;
            }
            finally
            {
                Thread.CurrentThread.CurrentCulture = originalCulture;
            }
        }

        protected override void Dispose(bool dispose)
        {
            DaoFactory.DisposeDao(artistDao);
            DaoFactory.DisposeDao(performanceDao);
            DaoFactory.DisposeDao(venueDao);
        }
    }
}
