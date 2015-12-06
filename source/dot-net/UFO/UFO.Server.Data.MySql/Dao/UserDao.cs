using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using System.Data;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Dao
{
    public class UserDao : MySqlBaseDao<long?, User>, IUserDao
    {
        public UserDao(MySqlConnection connection = null) : base(connection) { }
        public User GetAdminUserForUsername(string username)
        {
            if (username != null)
            {
                using (IDataReader reader = commandBuilder.WithQuery("SELECT * FROM ufo.user WHERE username = ?username AND user_type = ?userType")
                              .SetParameter("?username", username)
                              .SetParameter("?userType", User.UserType.ADMINISTRATOR)
                              .ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return EntityBuilder.CreateFromReader<long?, User>(reader);
                    }
                }
            }
            return null;
        }
    }
}
