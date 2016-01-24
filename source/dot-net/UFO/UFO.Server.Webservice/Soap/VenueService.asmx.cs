using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Serialization;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Webservice.Soap.Model;
using UFO.Server.Webservice.Soap.Model.Base;
using UFO.Server.Webservice.Soap.Soap.Base;

namespace UFO.Server.Webservice.Soap.Soap
{
    /// <summary>
    /// Summary description for VenueService
    /// </summary>
    [WebService(Namespace = "https://webservice.ufo.swk.ooe.fh.at/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class VenueService : BaseSecureWebservice
    {

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ListResultModel<VenueModel> GetVenues()
        {
            IVenueDao venueDao = DaoFactory.CreateVenueDao();
            ListResultModel<VenueModel> model;
            if ((model = HandleAuthentication<ListResultModel<VenueModel>>()) == null)
            {
                model = new ListResultModel<VenueModel>();
                try
                {
                    IList<Venue> venues = venueDao.FindAll();
                    model.Result = venues.Select(venue => new VenueModel
                    {
                        Id = venue.Id.Value,
                        Name = venue.Name,
                        FullAddress = (new StringBuilder(venue.Street).Append(", ").Append(venue.Zip).Append(" - ").Append(venue.City).ToString()),
                        GpsCoordinates = (venue.GpsCoordinate != null) ? venue.GpsCoordinate : null
                    }).ToList();
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetVenues: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ($"Error during processing the request. exception={e.GetType().Name}");
                }
                finally
                {
                    DaoFactory.DisposeDao(venueDao);
                }
            }

            return model;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ListResultModel<VenueModel> GetVenuesForPerformances(PerformanceFilterRequest filter)
        {
            return GetVenueForPerformances(null, filter);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ListResultModel<VenueModel> GetVenueForPerformances(long? id, PerformanceFilterRequest filter)
        {
            IPerformanceDao performanceDao = DaoFactory.CreatePerformanceDao();
            ListResultModel<VenueModel> model;
            if ((model = HandleAuthentication<ListResultModel<VenueModel>>()) == null)
            {
                model = new ListResultModel<VenueModel>();
                try
                {
                    IList<Performance> entities = performanceDao.GetFilteredPerformancesForExport(id, filter.StartDate, filter.EndDate, filter.ArtistIds, filter.VenueIds, filter.ArtistGroupIds, filter.ArtistCategoryIds, filter.Countries, true, filter.Moved);
                    IDictionary<Venue, List<Performance>> mapEntities = entities.GroupBy(entity => entity.Venue).ToDictionary(entry => entry.Key, entry => entry.ToList());
                    model.Result = mapEntities.Select(entry =>
                    {
                        Venue venue = entry.Key;
                        List<Performance> performances = entry.Value;
                        VenueModel venueModel = new VenueModel
                        {
                            Id = venue.Id.Value,
                            Name = venue.Name,
                            FullAddress = (new StringBuilder(venue.Street).Append(", ").Append(venue.Zip).Append(venue.City).Append(" AT").ToString()),
                            GpsCoordinates = venue.GpsCoordinate,
                            Performances = performances.Select(item => new PerformanceModel
                            {
                                Id = item.Id.Value,
                                Version = item.Version.Value,
                                StartDate = item.StartDate.Value,
                                EndDate = item.EndDate.Value,
                                FormerStartDate = item.FormerStartDate,
                                FormerEndDate = item.FormerEndDate,
                                Artist = new ArtistModel
                                {
                                    Id = item.Artist.Id.Value,
                                    FirstName = item.Artist.Firstname,
                                    LastName = item.Artist.Lastname,
                                    CountryCode = item.Artist.CountryCode,
                                    ArtistGroup = ((item.Artist.ArtistGroupId != null) ? item.Artist.ArtistGroup.Name : null),
                                    ArtistCategory = item.Artist.ArtistCategory.Name
                                },
                                Venue = new VenueModel
                                {
                                    Id = item.Venue.Id.Value,
                                    Name = item.Venue.Name
                                },
                                FormerVenue = ((item.FormerVenueId != null) ? new VenueModel
                                {
                                    Id = item.FormerVenue.Id.Value,
                                    Name = item.FormerVenue.Name
                                } : null)
                            }).ToList()
                        };
                        venueModel.Performances.Sort((o1, o2) => o1.StartDate.CompareTo(o2.StartDate));
                        return venueModel;
                    }).ToList();
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetVenueForPerformances: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ($"Error during processing the request. exception={e.GetType().Name}");
                }
                finally
                {
                    DaoFactory.DisposeDao(performanceDao);
                }
            }

            return model;
        }
    }
}
