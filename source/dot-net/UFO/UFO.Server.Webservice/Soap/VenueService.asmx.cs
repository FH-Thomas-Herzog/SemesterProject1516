﻿using System;
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
    public class VenueService : BaseSecureWebservice<VenueModel>
    {

        private IVenueDao venueDao = DaoFactory.CreateVenueDao();
        private IPerformanceDao performanceDao = DaoFactory.CreatePerformanceDao();

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public List<VenueModel> GetVenues()
        {
            List<VenueModel> models = new List<VenueModel>();
            VenueModel model = null;
            if ((model = HandleAuthentication()) == null)
            {
                try
                {
                    IList<Venue> venues = venueDao.FindAll();
                    models = venues.Select(venue => new VenueModel
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
                    models.Add(new VenueModel
                    {
                        ErrorCode = (int)ErrorCode.UNKNOWN_ERROR,
                        Error = ($"Error during processing the request. exception={e.GetType().Name}")
                    });
                }
            }
            else {
                models.Add(model);
            }
            return models;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public List<VenueModel> GetVenuesForPerformances(PerformanceFilterRequest filter)
        {
            return GetVenueForPerformances(null, filter);
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public List<VenueModel> GetVenueForPerformances(long? id, PerformanceFilterRequest filter)
        {
            List<VenueModel> models = null;
            VenueModel model = null;
            if ((model = HandleAuthentication()) == null)
            {
                try
                {
                    IList<Performance> entities = performanceDao.GetFilteredPerformancesForExport(id, filter.StartDate, filter.EndDate, filter.ArtistIds, filter.VenueIds, true);
                    IDictionary<Venue, List<Performance>> mapEntities = entities.GroupBy(entity => entity.Venue).ToDictionary(entry => entry.Key, entry => entry.ToList());
                    models = mapEntities.Select(entry =>
                    {
                        Venue venue = entry.Key;
                        List<Performance> performances = entry.Value;
                        return new VenueModel
                        {
                            Id = venue.Id.Value,
                            Name = venue.Name,
                            FullAddress = (new StringBuilder(venue.Street).Append(", ").Append(venue.Zip).Append(venue.City).Append(" AT").ToString()),
                            GpsCoordinates = venue.GpsCoordinate,
                            Performances = performances.Select(entity => new PerformanceModel
                            {
                                Id = entity.Id.Value,
                                StartDate = entity.StartDate.Value,
                                EndDate = entity.EndDate.Value,
                                FormerStartDate = entity.FormerStartDate,
                                Artist = new ArtistModel
                                {
                                    Id = entity.Artist.Id.Value,
                                    FirstName = entity.Artist.Firstname,
                                    LastName = entity.Artist.Lastname,
                                },
                                Venue = new VenueModel
                                {
                                    Id = entity.Venue.Id.Value,
                                    Name = entity.Venue.Name
                                }
                            }).ToList()
                        };
                    }).ToList();
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetVenueForPerformances: Error during processing. error: " + e.Message);
                    models.Add(new VenueModel
                    {
                        ErrorCode = (int)ErrorCode.UNKNOWN_ERROR,
                        Error = ($"Error during processing the request. exception={e.GetType().Name}")
                    });
                }
            }
            else
            {
                models.Add(model);
            }
            return models;
        }
    }
}