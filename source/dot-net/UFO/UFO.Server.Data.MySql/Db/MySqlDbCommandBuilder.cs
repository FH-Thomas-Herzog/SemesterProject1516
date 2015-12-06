using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Data.MySql.Db
{
    /// <summary>
    /// MySql specific implementation for the BaseDbCommandBuilder.
    /// It would contain MySql specifc stuff.
    /// </summary>
    public class MySqlDbCommandBuilder : BaseDbCommandBuilder<MySqlConnection, MySqlCommand, MySqlParameter, MySqlDbType>
    {
    }
}
