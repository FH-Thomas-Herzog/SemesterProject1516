using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Db
{

    /// <summary>
    /// This builder creates a command and allows convenient
    /// way to add parameters where the parameter type is resolved from the 
    /// parameter value type
    /// </summary>
    /// <typeparam name="T">The type of the to create DbCommand</typeparam>
    /// <typeparam name="P">The type of the used DbParameter</typeparam>
    public class DbCommandBuilder<T, P> where T : DbCommand where P : DbParameter
    {
        T command = null;

        DbCommandBuilder<T, P> Start(string query)
        {
            Debug.Assert(query != null);

            command = default(T);
            command.CommandText = query;

            return this;
        }

        DbCommandBuilder<T, P> SetParameter(string name, object value)
        {
            Debug.Assert(name != null);
            Debug.Assert(value != null);

            if (!command.Parameters.Contains(name))
            {
                P parameter = default(P);
                parameter.ParameterName = name;
                parameter.DbType = EvaluateType();
                command.Parameters.Add(parameter);
            }
            command.Parameters[name].Value = value;

            return this;
        }

        T Build()
        {
            return command;
        }

        #region Private
        private DbType EvaluateType()
        {
            return DbType.AnsiString;
        }
        #endregion
    }
}
