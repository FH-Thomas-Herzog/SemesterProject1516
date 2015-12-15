using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Exception;
using UFO.Commander.Service.Impl.Base;
using UFO.Server.Data.Api.Dao;
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
                performance.StartDate = performance.StartDate.Value.AddMilliseconds(-performance.StartDate.Value.Millisecond);
                performance.StartDate = performance.StartDate.Value.AddSeconds(-performance.StartDate.Value.Second);
                performance.EndDate = performance.EndDate.Value.AddMilliseconds(-performance.EndDate.Value.Millisecond);
                performance.EndDate = performance.EndDate.Value.AddSeconds(-performance.EndDate.Value.Second);

                // Validate if artist has already a performance with the defined date + offset
                DateTime startDateWithOffset = performance.StartDate.Value;
                DateTime endDateWithOffset = performance.EndDate.Value;
                startDateWithOffset = startDateWithOffset.AddHours(-hourOffset);
                endDateWithOffset = endDateWithOffset.AddHours(hourOffset);
                if (performanceDao.ArtistHasPerformanceOnDate(performance.ArtistId, startDateWithOffset, endDateWithOffset, performance.Id ?? -1))
                {
                    throw new ServiceException((int)PerformanceErrorCode.ARTIST_OVERBOOKED);
                }

                // New performance
                if (performance.Id == null)
                {
                    performanceDB = performanceDao.Persist(performance);
                }
                // Update existing one
                else
                {
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

        protected override void Dispose(bool dispose)
        {
            DaoFactory.DisposeDao(artistDao);
            DaoFactory.DisposeDao(performanceDao);
            DaoFactory.DisposeDao(venueDao);
        }
    }
}
