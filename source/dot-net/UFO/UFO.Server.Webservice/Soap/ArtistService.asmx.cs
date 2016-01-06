using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Serialization;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Dao;
using UFO.Server.Webservice.Soap.Model;
using UFO.Server.Webservice.Soap.Model.Base;
using UFO.Server.Webservice.Soap.Soap.Authentication;
using UFO.Server.Webservice.Soap.Soap.Base;

namespace UFO.Server.Webservice.Soap
{
    /// <summary>
    /// Summary description for DetailsService
    /// </summary>
    [WebService(Namespace = "https://webservice.ufo.swk.ooe.fh.at/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ArtistService : BaseSecureWebservice<ArtistModel>
    {
        private IArtistDao artistDao = DaoFactory.CreateArtistDao();
        private IArtistGroupDao artistGroupDao = DaoFactory.CreateArtistGroupDao();

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ArtistModel GetDetails(long id)
        {
            ArtistModel model = null;
            if ((model = handleAuthentication()) == null)
            {
                try
                {
                    Artist artist = artistDao.Find(id);
                    ArtistGroup group = artistGroupDao.Find(artist.ArtistGroupId);
                    if (artist != null)
                    {
                        return new ArtistModel
                        {
                            FirstName = artist.Firstname,
                            LastName = artist.Lastname,
                            Email = artist.Email,
                            CountryCode = artist.CountryCode,
                            Image = artist.ImageData,
                            ImageType = artist.ImageFileType,
                            ArtistGroup = ((group != null) ? group.Name : "")
                        };
                    }
                    else {
                        return new ArtistModel
                        {
                            ErrorCode = (int)ErrorCode.ENTRY_NOT_FOUND,
                            Error = "Artist could not be found for id"
                        };
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetDetails: Error during processing. error: " + e.Message);
                    return new ArtistModel
                    {
                        ErrorCode = (int)ErrorCode.UNKNOWN_ERROR,
                        Error = ($"Error during processing the request. exception={e.GetType().Name}")
                    };
                }
            }
            else {
                return model;
            }
        }
    }
}
