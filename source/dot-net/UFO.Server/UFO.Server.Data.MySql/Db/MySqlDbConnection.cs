using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Data.MySql.Db
{
    public class MySqlDbConnection : IConnection<MySqlConnection, MySqlCommand>
    {
        public void CloseConnection(MySqlConnection connection)
        {
            throw new NotImplementedException();
        }

        public MySqlConnection GetConnection()
        {
            throw new NotImplementedException();
        }
    }
}
