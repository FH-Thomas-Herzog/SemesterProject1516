using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
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
    public class PerformanceService : BaseSecureWebservice<PerformanceModel>
    {
        private IPerformanceDao performanceDao = DaoFactory.CreatePerformanceDao();

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public List<PerformanceModel> GetPerformances(PerformanceFilterRequest filter)
        {
            List<PerformanceModel> models = new List<PerformanceModel>();
            PerformanceModel model = null;
            if ((model = handleAuthentication()) == null)
            {
                try
                {
                    IList< Performance> performances = performanceDao.GetFilteredPerformancesFull(filter.StartDate, filter.EndDate, filter.ArtistIds, filter.VenueIds);
                    foreach (var item in performances)
                    {
                        models.Add(new PerformanceModel {
                            Id = item.Id.Value,
                            StartDate = item.StartDate.Value,
                            EndDate = item.EndDate.Value,
                            Moved = (item.FormerStartDate != null),
                            ArtistName = (new StringBuilder(item.Artist.Lastname).Append(", ").Append(item.Artist.Firstname).ToString()),
                            VenueName = item.Venue.Name,
                            ArtistId = item.Artist.Id,
                            VenueId = item.Venue.Id.Value
                        });
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetPerformances: Error during processing. error: " + e.Message);
                    models.Add(new PerformanceModel
                    {
                        ErrorCode = (int)ErrorCode.UNKNOWN_ERROR,
                        Error = ("Error during processing the request. error: " + e.Message)
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
        public PerformanceModel GetDetails(long id)
        {
            PerformanceModel model = null;
            if ((model = handleAuthentication()) == null)
            {
                try
                {
                    Performance performance = performanceDao.Find(id);
                    if (performance != null)
                    {
                        return new PerformanceModel
                        {
                        };
                    }
                    else {
                        return new PerformanceModel
                        {
                            ErrorCode = (int)ErrorCode.ENTRY_NOT_FOUND,
                            Error = "Artist could not be found for id"
                        };
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetDetails: Error during processing. error: " + e.Message);
                    return new PerformanceModel
                    {
                        ErrorCode = (int)ErrorCode.UNKNOWN_ERROR,
                        Error = ("Error during processing the request. error: " + e.Message)
                    };
                }
            }
            else {
                return model;
            }
        }
    }
}
