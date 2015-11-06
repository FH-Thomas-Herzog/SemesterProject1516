using FO.Server.Data.MySql.Api;
using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Db;

namespace FO.Server.Data.MySql.Dao
{
    public abstract class MySqlBaseDao<I, E> : BaseDao<I, E, MySqlDbCommandBuilder, MySqlConnection, MySqlCommand, MySqlParameter, MySqlDbType, MySqlQueryCreator> where E : class, IEntity<I>
    {
        protected override MySqlDbCommandBuilder prepareCommandBuilder()
        {
            MySqlDbCommandBuilder builder = new MySqlDbCommandBuilder();
            builder.WithConnection((MySqlConnection)DbConnectionFactory.CreateAndOpenConnection())
                               .WithTypeResolver(new MySqlDbTypeResolver());

            return builder;
        }
    }
}
