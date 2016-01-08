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

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public List<VenueModel> GetVenues()
        {
            List<VenueModel> models = new List<VenueModel>();
            VenueModel model = null;
            if ((model = handleAuthentication()) == null)
            {
                try
                {
                    IList<Venue> venues = venueDao.FindAll();
                    foreach (var venue in venues)
                    {
                        models.Add(new VenueModel
                        {
                            Id = venue.Id.Value,
                            Name = venue.Name,
                            FullAddress = (new StringBuilder(venue.Street).Append(", ").Append(venue.Zip).Append(" - ").Append(venue.City).ToString()),
                            GpsCoordinates = (venue.GpsCoordinate != null) ? venue.GpsCoordinate : null
                        });
                    }
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
    }
}
