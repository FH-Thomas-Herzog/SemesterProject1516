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

namespace UFO.Server.Webservice.Soap
{
    /// <summary>
    /// Summary description for DetailsService
    /// </summary>
    [WebService(Namespace = "https://ufo.swk.fh-ooe.at/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ArtistService : System.Web.Services.WebService
    {
        public Credentials credentials;
        private IArtistDao artistDao = DaoFactory.CreateArtistDao();
        private IArtistGroupDao artistGroupDao = DaoFactory.CreateArtistGroupDao();

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ArtistModel GetDetails([XmlElement(DataType = "integer", IsNullable = false)]string id)
        {
            ArtistModel model = null;
            if ((model = handleAuthentication()) == null)
            {
                try
                {
                    Artist artist = artistDao.Find((long)Convert.ToDecimal(id));
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
                        Error = ("Error during processing the request. error: " + e.Message)
                    };
                }
            }
            else {
                return model;
            }
        }

        /// <summary>
        /// Handles the authentication.
        /// </summary>
        /// <returns>the artist model which holds the information, or null if authentication succeeded</returns>
        private ArtistModel handleAuthentication()
        {
            if ((credentials == null) || (!credentials.IsValid()))
            {
                Console.WriteLine("GetDetails: " + ((credentials == null) ? "no authentication data given" : $"Authentication failed for user '{credentials.Username}'"));
                return new ArtistModel
                {
                    ErrorCode = (int)((credentials == null) ? ErrorCode.AUTHENTICATION_MISSING : ErrorCode.AUTHENTICATION_FAILED),
                    Error = ((credentials == null) ? "No credentials were given" : "Authentication failed")
                };
            }
            return null;
        }
    }
}
