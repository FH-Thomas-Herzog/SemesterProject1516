using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Data.Util
{

    /// <summary>
    /// This builder creates a command and allows convenient
    /// way to add parameters where the parameter type is resolved from the 
    /// parameter value type
    /// </summary>
    /// <typeparam name="T">The type of the to create DbCommand</typeparam>
    /// <typeparam name="P">The type of the used DbParameter</typeparam>
    public class DbCommandBuilder<B, C, T, P, D> where B : DbConnection where C : IConnection<B, T> where T : DbCommand where P : DbParameter
    {
        IDbTypeResolver<D> typeResolver;
        C connection;
        T command = null;

        public DbCommandBuilder<B, C, T, P, D> WithTypeResolver(IDbTypeResolver<D> typeResolver)
        {
            this.typeResolver = typeResolver;
            return this;
        }

        public DbCommandBuilder<B, C, T, P, D> WithConnection(C connection)
        {
            Debug.Assert(connection != null, "Cannot set null conection on command");
            Debug.Assert(command != null, "Cannot set conction on null command. Seems Builder hasn't been started yet");

            this.connection = connection;
            return this;
        }

        public DbCommandBuilder<B, C, T, P, D> Start(string query)
        {
            Debug.Assert(typeResolver != null, "You need to call Init(...) before");
            Debug.Assert(query != null, "Cannot start command with null query string");

            command = (T)Activator.CreateInstance(typeof(T));
            command.CommandText = query;

            return this;
        }

        public DbCommandBuilder<B, C, T, P, D> SetParameter(string name, object value)
        {
            Debug.Assert(name != null);
            Debug.Assert(value != null);

            if (!command.Parameters.Contains(name))
            {
                P parameter = createParameter(name, EvaluateType(value));
                command.Parameters.Add(parameter);
            }
            command.Parameters[name].Value = value;

            return this;
        }


        public T Build()
        {
            return command;
        }

        public DbCommandBuilder<B, C, T, P, D> Clear()
        {
            command = null;
            typeResolver = null;
            return this;
        }

        #region Private
        private P createParameter(string name, D type)
        {
            try
            {
                return (P)Activator.CreateInstance(typeof(P), name, type);
            }
            catch (System.Exception)
            {
                throw new ApplicationException("Cannot create parameter '" + nameof(P) + "' ");
            }
        }
        private D EvaluateType(object value)
        {
            try
            {
                return (D)typeResolver.resolve(value.GetType());
            }
            catch (System.Exception)
            {
                throw new ArgumentException("idResolver cannot resolve type: '" + value.GetType().Name + "' to proper DbType");
            }
        }
        #endregion
    }
}
