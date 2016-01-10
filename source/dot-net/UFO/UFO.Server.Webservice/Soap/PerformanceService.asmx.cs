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
                    IList<Performance> performances = performanceDao.GetFilteredPerformancesForExport(null, filter.StartDate, filter.EndDate, filter.ArtistIds, filter.VenueIds, false);
                    models = performances.Select(item => new PerformanceModel
                    {
                        Id = item.Id.Value,
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
    }
}
