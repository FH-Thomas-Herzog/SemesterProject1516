using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Data.MySql.Db
{
    public class MySqlDbTypeResolver : IDbTypeResolver<MySqlDbType>
    {
        public static readonly Dictionary<Type, MySqlDbType> TYPE_MAP = new Dictionary<Type, MySqlDbType>{
            {typeof(Int16), MySqlDbType.Int16 },
            { typeof(Int32), MySqlDbType.Int32 },
            {typeof(Int64), MySqlDbType.Int64 },
            {typeof(string), MySqlDbType.VarChar},
            {typeof(double), MySqlDbType.Double},
            {typeof(float), MySqlDbType.Float},
            {typeof(bool), MySqlDbType.Int16},
            {typeof(DateTime), MySqlDbType.DateTime},
            {typeof(DateTime?), MySqlDbType.DateTime}
        };

        public MySqlDbType resolve(Type type)
        {
            Debug.Assert(type != null, "Cannot resolve MySqlDbType for given null type");

            if (!TYPE_MAP.ContainsKey(type))
            {
                throw new ArgumentException("Type '" + type.Name + "' has no mapping to a MySqlDbType");
            }

            return TYPE_MAP[type];
        }
    }
}
