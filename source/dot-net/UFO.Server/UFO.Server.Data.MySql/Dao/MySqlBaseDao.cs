using FO.Server.Data.MySql.Api;
using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Db;

namespace FO.Server.Data.MySql.Dao
{

    /// <summary>
    /// Base implementation which prepares a mysql dao.
    /// It inherits all BaseDao implementations and would contain MySQl specific stuff.
    /// </summary>
    /// <typeparam name="I">the type of the entity id</typeparam>
    /// <typeparam name="E">the type of the entity</typeparam>
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
