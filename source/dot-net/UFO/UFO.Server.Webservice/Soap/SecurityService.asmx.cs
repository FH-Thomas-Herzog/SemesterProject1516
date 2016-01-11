using System;
using System.Collections.Generic;
using System.Linq;
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
    /// Summary description for SecurityWebservice
    /// </summary>
    [WebService(Namespace = "https://webservice.ufo.swk.ooe.fh.at/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class SecurityService : BaseSecureWebservice<LoginModel>
    {

        private IUserDao userDao = DaoFactory.CreateUserDao();

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public LoginModel ValidateUserCredentials(string username, string password)
        {
            LoginModel model;
            if ((model = HandleAuthentication()) == null)
            {
                try
                {
                    User user = userDao.GetAdminUserForUsername(username);
                    if ((user != null) && ((BCrypt.Net.BCrypt.Verify(password, user.Password))))
                    {
                        model = new LoginModel
                        {
                            Valid = true
                        };
                    }
                    else
                    {
                        model = new LoginModel
                        {
                            Valid = false
                        };
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetVenues: Error during processing. error: " + e.Message);
                    model = new LoginModel
                    {
                        ErrorCode = (int)ErrorCode.UNKNOWN_ERROR,
                        Error = ($"Error during processing the request. exception={e.GetType().Name}")
                    };
                }
            }
            return model;
        }
    }
}
