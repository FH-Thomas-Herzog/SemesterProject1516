using System;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using UFO.Server.Data.Api.Exception;

namespace UFO.Server.Data.Api.Db
{

    /// <summary>
    /// This builder creates a command and allows convenient
    /// way to add parameters where the parameter type is resolved from the 
    /// parameter value type
    /// </summary>
    /// <typeparam name="B">the type of the db connection</typeparam>
    /// <typeparam name="T">The type of the to create DbCommand</typeparam>
    /// <typeparam name="P">The type of the used DbParameter</typeparam>
    /// <typeparam name="D">the type of the db type enumeration</typeparam>
    public abstract class BaseDbCommandBuilder<B, T, P, D, I> where B : DbConnection where T : DbCommand where P : DbParameter where I : BaseDbCommandBuilder<B, T, P, D, I>
    {
        IDbTypeResolver<D> typeResolver;
        B connection;
        T command = null;

        /// <summary>
        /// Sets the given type resolver on the builder which resolves an c# type to the proper db type. 
        /// </summary>
        /// <param name="typeResolver">the type resolver to be set</param>
        /// <returns>the currnt builder instance</returns>
        public I WithTypeResolver(IDbTypeResolver<D> typeResolver)
        {
            this.typeResolver = typeResolver;
            return (I) this;
        }

        /// <summary>
        /// Sets the given connection on the current builder instance
        /// </summary>
        /// <param name="connection">the connection to be set</param>
        /// <returns>the current builder instance</returns>
        public I WithConnection(B connection)
        {
            ClearWithConnection();

            this.connection = connection;

            return (I) this;
        }

        /// <summary>
        /// Clears the builder instance completely.
        /// The command and connection are closed and disposed
        /// </summary>
        /// <returns>the current builder instance</returns>
        public I ClearWithConnection()
        {
            // clears command
            Clear();
            // clears connection
            DbConnectionFactory.CloseDisposeConnection(connection);
            connection = null;

            return (I)this;
        }

        /// <summary>
        /// Creates an command for the given query and closes and diposes any former used command instance
        /// </summary>
        /// <param name="query">the query to create an command for</param>
        /// <returns>the current builder instance</returns>
        public I WithQuery(string query)
        {
            Debug.Assert(typeResolver != null, "You need to call Init(...) before");
            Debug.Assert(query != null, "Cannot start command with null query string");

            if (command != null)
            {
                Clear();
            }
            command = (T)Activator.CreateInstance(typeof(T));
            command.CommandText = query;
            command.Connection = connection;

            return (I) this;
        }

        /// <summary>
        /// Sets the parameter on the backed command
        /// </summary>
        /// <param name="name">the name of the parameter</param>
        /// <param name="value">the value for the parameter</param>
        /// <returns>the current builder instance</returns>
        public I SetParameter(string name, object value)
        {
            Debug.Assert(name != null);

            if (!command.Parameters.Contains(name))
            {
                P parameter = (value != null) ? createParameter(name, EvaluateType(value)) : createParameter(name);
                command.Parameters.Add(parameter);
            }
            command.Parameters[name].Value = value;

            return (I)this;
        }
        
        /// <summary>
        /// Gets the current set command which could be null.
        /// </summary>
        /// <returns>the bakced command, could be null</returns>
        public T Command()
        {
            return command;
        }

        /// <summary>
        /// Executes the reader on the backed command.
        /// </summary>
        /// <param name="behavior">the behaviour to be used for the execution</param>
        /// <returns>the reader holding the result of the executed command</returns>
        public IDataReader ExecuteReader(CommandBehavior behavior = CommandBehavior.Default)
        {
            Debug.Assert(Command() != null, "Cannot execute a reader on a null command");

            return Command().ExecuteReader(behavior);
        }

        /// <summary>
        /// Executes a non query on the backed command
        /// </summary>
        /// <returns>the row count of the manipulated rows</returns>
        public int ExecuteNonQuery()
        {
            Debug.Assert(Command() != null, "Cannot execute a non query on a null command");

            return Command().ExecuteNonQuery();
        }

        /// <summary>
        /// Performs a scalar execution of the backed command.
        /// </summary>
        /// <returns>the result of hte executed scalar command</returns>
        public object ExecuteScalar()
        {
            Debug.Assert(Command() != null, "Cannot execute scalar command on a null command");

            return Command().ExecuteScalar();
        }

        /// <summary>
        /// Clears the builder by closing and disposing the bakced command if not null.
        /// </summary>
        /// <returns>the current builder instance</returns>
        public I Clear()
        {
            if (command != null)
            {
                command.Dispose();
            }
            command = null;

            return (I)this;
        }

        #region Private
        /// <summary>
        /// Creates an parameter via reflection for the set type.
        /// </summary>
        /// <param name="name">the name of the parameter</param>
        /// <returns>the create parameter instance</returns>
        private P createParameter(string name)
        {
            Debug.Assert(name != null, "Cannot create a parameter for a nul name");

            try
            {
                return (P)Activator.CreateInstance(typeof(P), name, (object)null);
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Cannot create parameter '" + name + "'", e);
            }
        }

        /// <summary>
        /// Creas a command for the given name and type.
        /// </summary>
        /// <param name="name">the name of the parameter</param>
        /// <param name="type">the type of the parameter</param>
        /// <returns></returns>
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

        /// <summary>
        /// Evaluates the db type of the given c# type.
        /// </summary>
        /// <param name="value">the value to retrieve db type from</param>
        /// <returns></returns>
        private D EvaluateType(object value)
        {
            try
            {
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
