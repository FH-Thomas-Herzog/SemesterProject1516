using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using BCrypt.Net;

namespace UFO.Commander.Service.Impl
{
    public class SecurityService : ISecurityService
    {
        public User Login(string username, string password)
        {
            if ((username != null) && (password != null))
            {
                User user = DaoFactory.CreateUserDao().GetAdminUserForUsername(username);
                if ((user != null) && (BCrypt.Net.BCrypt.Verify(password, user.Password)))
                {
                    return user;
                }
            }
            return null;
        }

        public void Dispose()
        {
            // Release DAOs here 
        }

    }
}
