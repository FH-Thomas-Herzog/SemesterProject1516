using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Service.Impl
{
    public class SecurityService : ISecurityService
    {
        public User Login(string username, string password)
        {
            return null;
        }

        public void Dispose()
        {
            // Release DAOs here 
        }

    }
}
