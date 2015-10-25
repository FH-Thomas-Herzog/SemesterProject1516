using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Db
{
    public class MySqlSelectQueryBuilder<I, E> : BaseSelectQueryBuilder<I, E, MySqlCommand, MySqlConnection, MySqlDbConnection, MySqlParameter, MySqlDbCommandBuilder, MySqlDbType> where E : class, IEntity<I>
    {
        public override string ToQuery()
        {
            if (!validToBuild())
            {
                throw new ArgumentException("Cannot build select statement with no projection");
            }
            StringBuilder sb = new StringBuilder(500);
            // Build select clause
            sb.Append("SELECT ");
            string[] selects = base.selectedProperties.ToArray();
            for (var i = 0; i < selects.Length; i++)
            {
                sb.Append(entityBuilder.ConvertPropertyToColumn(selects[i]));
                if (i < (selects.Length - 1))
                {
                    sb.Append(", ");
                }
            }

            // Build from clause
            sb.Append(" FROM ").Append(entityBuilder.tableName).Append(" ");

            // Build Where clause
            bool first = true;
            int idx = 0;
            foreach (var item in base.whereProperties)
            {
                foreach (var entry in item)
                {
                    sb.Append((first) ? " WHERE " : " AND ");
                    first = false;
                    sb.Append(entry.Key).Append(" = ").Append("@").Append(entityBuilder.ConvertPropertyToColumn(entry.Key)).Append("_").Append(idx);
                    idx++;
                }
            }

            // Build Where clause
            int innerIdx = 0;
            foreach (var whereKey in base.whereInProperties)
            {
                sb.Append((first) ? " WHERE " : " AND ");
                first = false;
                sb.Append(whereKey.Key).Append(" IN(");
                innerIdx = 0;
                foreach (var value in whereKey.Value)
                {
                    sb.Append("@").Append(entityBuilder.ConvertPropertyToColumn(whereKey.Key)).Append("_").Append(idx).Append("_").Append(innerIdx);
                    innerIdx++;
                    if (innerIdx < whereKey.Value.Count)
                    {
                        sb.Append(", ");
                    }
                }
                sb.Append(")");
            }
            return sb.ToString();
        }

        public override MySqlCommand ToCommand()
        {
            return null;
        }

        public override E Execute()
        {
            if (commandBuilder == null)
            {
                throw new System.Exception("Cannot execute query with no DbCommandBuilder set");
            }
            commandBuilder.Start(ToQuery());
            int idx = 0;
            int innerIdx = 0;
            if (whereProperties.Count > 0)
            {
                foreach (var item in whereProperties)
                {
                    foreach (var entry in item)
                    {
                        string property = entityBuilder.ConvertPropertyToColumn(entry.Key) + "_" + idx;
                        commandBuilder.SetParameter(property, entry.Value);
                        idx++;
                    }
                }
            }
            if (whereInProperties.Count > 0)
            {
                innerIdx = 0;
                foreach (var entry in whereInProperties)
                {
                    string property = entityBuilder.ConvertPropertyToColumn(entry.Key) + "_" + idx + "_" + innerIdx;
                    commandBuilder.SetParameter(entityBuilder.ConvertPropertyToColumn(entry.Key), entry.Value);
                    innerIdx++;
                }
            }

            MySqlCommand command = commandBuilder.Build();
            return null;
        }
    }
}
