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
    public class SecurityService : BaseSecureWebservice
    {

        private IUserDao userDao = DaoFactory.CreateUserDao();

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public SingleResultModel<bool?> ValidateUserCredentials(string username, string password)
        {
            SingleResultModel<bool?> model;
            if ((model = HandleAuthentication<SingleResultModel<bool?>>()) == null)
            {
                model = new SingleResultModel<bool?>();
                try
                {
                    User user = userDao.GetAdminUserForUsername(username);
                    if ((user != null) && ((BCrypt.Net.BCrypt.Verify(password, user.Password))))
                    {
                        model.Result = true;
                    }
                    else
                    {
                        model.Result = false;
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetVenues: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ($"Error during processing the request. exception={e.GetType().Name}");
                }
            }
            else
            {
                model.Result = false;
            }
            return model;
        }
    }
}
