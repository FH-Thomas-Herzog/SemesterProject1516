using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Impl.Base;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;

namespace UFO.Commander.Service.Impl
{
    public class UserService : BaseService, IUserService
    {
        private IUserDao userDao;
        public UserService(DbConnection connection = null) : base(connection)
        {
            userDao = DaoFactory.CreateUserDao(Connection);
        }

        public User Save(User user)
        {
            try
            {
                User userDB = null;
                StartTx();
                userDB = userDao.Update(user);
                CommitTx();
                return userDB;
            }
            catch (Exception e)
            {
                RollbackTx();
                throw e;
            }
        }
        public void Delete(long? id)
        {
            try
            {
                StartTx();
                userDao.Delete(id);
                CommitTx();
            }catch(Exception e)
            {
                RollbackTx();
                throw e;
            }
        }
    }
}
