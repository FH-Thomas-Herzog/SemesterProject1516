using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Helper;
using UFO.Server.Data.MySql.Db;

namespace UFO.Server.Data.MySql.Helper
{
    public abstract class BaseMySqlEntityHelper<I, E> : BaseEntityHelper<I, E, MySqlDbCommandBuilder, MySqlConnection, MySqlCommand, MySqlParameter, MySqlDbType, MySqlQueryCreator> where E : class, IEntity<I>
    {
        public override MySqlDbCommandBuilder PrepareCommandBuilder()
        {
            MySqlDbCommandBuilder builder = new MySqlDbCommandBuilder();
            builder.WithConnection((MySqlConnection)DbConnectionFactory.CreateAndOpenConnection())
                                                                       .WithTypeResolver(new MySqlDbTypeResolver());

            return builder;
        }

    }
}
