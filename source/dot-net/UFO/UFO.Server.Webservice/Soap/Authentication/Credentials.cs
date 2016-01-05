using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Web;

namespace UFO.Server.Webservice.Soap.Soap.Authentication
{
    public class Credentials : System.Web.Services.Protocols.SoapHeader
    {
        public string Username { get; set; }
        public string Password { get; set; }

        private static IDictionary<string, string> registered;
        private const string REGISTERED_APPLICATIONS_COLLECTION = "RegisteredApplications";

        static Credentials()
        {
            Hashtable table = (Hashtable)ConfigurationManager.GetSection(REGISTERED_APPLICATIONS_COLLECTION);
            registered = table.Cast<DictionaryEntry>().ToDictionary(d => d.Key as string, d => d.Value as string);
        }

        public bool IsValid()
        {
            string password = null;
            registered.TryGetValue(Username, out password);
            return ((password != null) && (Password != null) && (Password.Equals(password)));
        }
    }
}