using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Dao
{
    public class PerformanceDao : MySqlBaseDao<long?, Performance>, IPerformanceDao
    {
        public PerformanceDao(MySqlConnection connection = null) : base(connection) { }
    }
}
