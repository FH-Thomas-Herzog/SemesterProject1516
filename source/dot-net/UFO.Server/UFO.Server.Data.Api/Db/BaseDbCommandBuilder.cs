using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Exception;

namespace UFO.Server.Data.Api.Db
{

    /// <summary>
    /// This builder creates a command and allows convenient
    /// way to add parameters where the parameter type is resolved from the 
    /// parameter value type
    /// </summary>
    /// <typeparam name="T">The type of the to create DbCommand</typeparam>
    /// <typeparam name="P">The type of the used DbParameter</typeparam>
    public abstract class BaseDbCommandBuilder<B, T, P, D> where B : DbConnection where T : DbCommand where P : DbParameter
    {
        IDbTypeResolver<D> typeResolver;
        B connection;
        T command = null;

        public BaseDbCommandBuilder<B, T, P, D> WithTypeResolver(IDbTypeResolver<D> typeResolver)
        {
            this.typeResolver = typeResolver;
            return this;
        }

        public BaseDbCommandBuilder<B, T, P, D> WithConnection(B connection)
        {
            Debug.Assert(connection != null, "Cannot set null conection on command");

            ClearWithConnection();

            this.connection = connection;

            return this;
        }
        public BaseDbCommandBuilder<B, T, P, D> ClearWithConnection()
        {
            // clears command
            Clear();
            // clears connection
            DbConnectionFactory.CloseDisposeConnection(connection);
            connection = null;

            return this;
        }


        public BaseDbCommandBuilder<B, T, P, D> WithQuery(string query)
        {
            Debug.Assert(typeResolver != null, "You need to call Init(...) before");
            Debug.Assert(query != null, "Cannot start command with null query string");

            if(command != null)
            {
                Clear();
            }
            command = (T)Activator.CreateInstance(typeof(T));
            command.CommandText = query;
            command.Connection = connection;

            return this;
        }

        public BaseDbCommandBuilder<B, T, P, D> SetParameter(string name, object value)
        {
            Debug.Assert(name != null);

            if (!command.Parameters.Contains(name))
            {
                P parameter = (value != null) ? createParameter(name, EvaluateType(value)) : createParameter(name);
                command.Parameters.Add(parameter);
            }
            command.Parameters[name].Value = value;

            return this;
        }

        public BaseDbCommandBuilder<B, T, P, D> SetArrayParameter<VT>(string name, VT[] values)
        {
            Debug.Assert(name != null);
            Debug.Assert(values != null);

            if (!command.Parameters.Contains(name))
            {
                P parameter = createParameter(name, EvaluateType(values));
                command.Parameters.Add(parameter);
            }
            command.Parameters[name].Value = null;

            return this;
        }


        public T Build()
        {
            return command;
        }

        public IDataReader ExecuteReader(CommandBehavior behavior)
        {
            return Build().ExecuteReader(behavior);
        }

        public int ExecuteNonQuery()
        {
            return Build().ExecuteNonQuery();
        }

        public BaseDbCommandBuilder<B, T, P, D> Clear()
        {
            if(command != null)
            {
                command.Dispose();
            }
            command = null;

            return this;
        }

        #region Private
        private P createParameter(string name)
        {
            try
            {
                return (P)Activator.CreateInstance(typeof(P), name, (object)null);
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Cannot create parameter '"+name+"'", e);
            }
        }

        private P createParameter(string name, D type)
        {
            try
            {
                if (type == null)
                {
                    return (P)Activator.CreateInstance(typeof(P), name);
                }
                return (P)Activator.CreateInstance(typeof(P), name, type);
            }
            catch (System.Exception)
            {
                throw new PersistenceException("Cannot create parameter '" + nameof(P) + "' ");
            }
        }

        private D EvaluateType(object value)
        {
            try
            {
                // TODO: Handle Array type
                return (D)typeResolver.resolve(value.GetType());
            }
            catch (System.Exception e)
            {
                throw new ArgumentException("idResolver cannot resolve type: '" + value.GetType().Name + "' to proper DbType", e);
            }
        }
        #endregion
    }
}
