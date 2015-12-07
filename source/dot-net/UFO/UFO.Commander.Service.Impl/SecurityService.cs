using System.Data.Common;
using UFO.Commander.Service.Api;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using UFO.Commander.Service.Impl.Base;

namespace UFO.Commander.Service.Impl
{
    public class SecurityService : BaseService, ISecurityService
    {
        private IUserDao userDao;

        public SecurityService(DbConnection connection = null) : base(connection)
        {
            userDao = DaoFactory.CreateUserDao(Connection);
        }

        public User Login(string username, string password)
        {
            if ((username != null) && (password != null))
            {
                User user = userDao.GetAdminUserForUsername(username);
                if ((user != null) && (BCrypt.Net.BCrypt.Verify(password, user.Password)))
                {
                    return user;
                }
            }
            return null;
        }

        public override void Dispose()
        {
            base.Dispose();
            DaoFactory.DisposeDao(userDao);
        }
    }
}
