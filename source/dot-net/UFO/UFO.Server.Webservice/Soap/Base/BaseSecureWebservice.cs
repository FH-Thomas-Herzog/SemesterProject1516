using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using UFO.Server.Webservice.Soap.Model.Base;
using UFO.Server.Webservice.Soap.Soap.Authentication;

namespace UFO.Server.Webservice.Soap.Soap.Base
{
    public abstract class BaseSecureWebservice<T> : WebService where T : BaseModel, new()
    {
        public Credentials credentials;

        /// <summary>
        /// Handles the authentication.
        /// </summary>
        /// <returns>the model which holds the error information, or null if authentication succeeded</returns>

        protected T HandleAuthentication()
        {
            if ((credentials == null) || (!credentials.IsValid()))
            {
                Console.WriteLine("GetDetails: " + ((credentials == null) ? "no authentication data given" : $"Authentication failed for user '{credentials.Username}'"));
                return new T
                {
                    ErrorCode = (int)((credentials == null) ? ErrorCode.AUTHENTICATION_MISSING : ErrorCode.AUTHENTICATION_FAILED),
                    Error = ((credentials == null) ? "No credentials were given" : "Authentication failed")
                };
            }
            return null;
        }
    }
}