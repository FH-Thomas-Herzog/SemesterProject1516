﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Service.Api.Exception;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Webservice.Soap.Model;
using UFO.Server.Webservice.Soap.Model.Base;
using UFO.Server.Webservice.Soap.Soap.Base;

namespace UFO.Server.Webservice.Soap.Soap
{
    /// <summary>
    /// Summary description for PerformanceService
    /// </summary>
    [WebService(Namespace = "https://webservice.ufo.swk.ooe.fh.at/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class PerformanceService : BaseSecureWebservice
    {
        private IPerformanceDao performanceDao = DaoFactory.CreatePerformanceDao();
        private ISecurityService securityService = ServiceFactory.CreateSecurityService();
        private IPerformanceService performanceService = ServiceFactory.CreatePerformanceService();

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ListResultModel<PerformanceModel> GetPerformances(PerformanceFilterRequest filter)
        {
            ListResultModel<PerformanceModel> model = null;
            if ((model = HandleAuthentication<ListResultModel<PerformanceModel>>()) == null)
            {
                model = new ListResultModel<PerformanceModel>();
                try
                {
                    IList<Performance> performances = performanceDao.GetFilteredPerformancesForExport(null, filter.StartDate, filter.EndDate, filter.ArtistIds, filter.VenueIds, false);
                    model.Result = performances.Select(item => new PerformanceModel
                    {
                        Id = item.Id.Value,
                        Version = item.Version.Value,
                        StartDate = item.StartDate.Value,
                        EndDate = item.EndDate.Value,
                        FormerStartDate = item.FormerStartDate,
                        Artist = new ArtistModel
                        {
                            Id = item.Artist.Id.Value,
                            FirstName = item.Artist.Firstname,
                            LastName = item.Artist.Lastname,
                        },
                        Venue = new VenueModel
                        {
                            Id = item.Venue.Id.Value,
                            Name = item.Venue.Name
                        }
                    }).ToList();
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetPerformances: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ("Error during processing the request. error: " + e.Message);
                }
            }

            return model;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public SingleResultModel<PerformanceModel> Save(PerformanceRequestModel request)
        {
            SingleResultModel<PerformanceModel> model = null;
            if ((model = HandleAuthentication<SingleResultModel<PerformanceModel>>()) == null)
            {
                try
                {
                    User user = null;
                    if ((user = securityService.Login(request.Username, request.Password)) != null)
                    {
                        model = new SingleResultModel<PerformanceModel>();
                        DateTime endDate = request.StartDate.AddHours(1);
                        Performance performance=null;
                        if (request.Id != null)
                        {
                            performance = performanceDao.ById(request.Id);
                        }
                        performance = performanceService.Save(new Performance
                        {
                            Id = request.Id,
                            Version = request.Version,
                            ArtistId = request.ArtistId,
                            VenueId = request.VenueId,
                            StartDate = request.StartDate,
                            EndDate = endDate,
                            CreationUserId = (performance != null) ? performance.CreationUserId : user.Id,
                            ModificationUserId = user.Id
                        }, 1);

                        model.Result = new PerformanceModel
                        {
                            Id = performance.Id.Value,
                            Version = performance.Version.Value,
                            StartDate = performance.StartDate.Value,
                            EndDate = performance.EndDate.Value,
                            Artist = new ArtistModel
                            {
                                Id = performance.ArtistId.Value
                            },
                            Venue = new VenueModel
                            {
                                Id = performance.VenueId.Value
                            }
                        };
                    }
                    else
                    {
                        model.Error = "Login failed";
                        model.ErrorCode = (int)ErrorCode.LOGN_FAILED;
                    }
                }
                catch (ServiceException e)
                {
                    model.Error = "Service throw error: " + e.Message;
                    model.ServiceErrorCode = (int)e.ErrorCode;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Save: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ("Error during processing the request. error: " + e.Message);
                }
            }

            return model;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public SingleResultModel<bool?> Delete(string username, string password, long id)
        {
            SingleResultModel<bool?> model = null;
            if ((model = HandleAuthentication<SingleResultModel<bool?>>()) == null)
            {
                model = new SingleResultModel<bool?>();
                try
                {
                    if (securityService.Login(username, password) != null)
                    {
                        performanceService.Delete(id);
                    }
                    else
                    {
                        model.Error = "Login failed";
                        model.ErrorCode = (int)ErrorCode.LOGN_FAILED;
                    }
                }
                catch (ServiceException e)
                {
                    model.Error = "Service throw error: " + e.Message;
                    model.ServiceErrorCode = (int)e.ErrorCode;
                }
                catch (Exception e)
                {
                    Console.WriteLine("Delete: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ("Error during processing the request. error: " + e.Message);
                }
            }
            return model;
        }

    }
}
