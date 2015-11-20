using System;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Reflection;
using UFO.Server.Data.Api.Exception;

namespace UFO.Server.Data.Api.Db
{

    /// <summary>
    /// This class represents the connection factory whic produces a connection
    /// depending on the current available assembly.
    /// </summary>
    public class DbConnectionFactory
    {
        private static string assemblyName;
        private static Type connectionType;
        private static Assembly assembly;
        private static string connectionString;

        private const string DB_PROVIDER_ASSEMBLY = "DbProviderAssembly";
        private const string CONNECTION_TYPE_NAME = "DbProviderAssemblyConnectionType";
        private const string CONNECTION_STRING = "UFODB";


        /// <summary>
        /// Initializes the DbConnectionFactory by loading the available assembly and connection type 
        /// for creation.
        /// The pooling should be performed via the underlying db provider which normally pools the 
        /// underlying connection to the database and not the connection type instances
        /// </summary>
        static DbConnectionFactory()
        {
            assemblyName = ConfigurationManager.AppSettings[DB_PROVIDER_ASSEMBLY];
            if (assemblyName == null)
            {
                throw new InvalidOperationException("Parameter '" + DB_PROVIDER_ASSEMBLY + "' not set in app.config");
            }
            string conTypeNamePart = ConfigurationManager.AppSettings[CONNECTION_TYPE_NAME];
            if (conTypeNamePart == null)
            {
                throw new InvalidOperationException("Parameter '" + CONNECTION_TYPE_NAME + "' not set in app.config");
            }
            string connectionTypeName = assemblyName + "." + conTypeNamePart;
            connectionString = ConfigurationManager.ConnectionStrings[CONNECTION_STRING].ConnectionString;
            if (connectionString == null)
            {
                throw new InvalidOperationException("Parameter '" + CONNECTION_STRING + "' not set in app.config");
            }

            assembly = Assembly.Load(assemblyName);
            connectionType = assembly.GetType(connectionTypeName);
        }


        /// <summary>
        /// Creates a new connection instance
        /// </summary>
        /// <returns>the connection instance</returns>
        public static DbConnection CreateConnection()
        {
            return Activator.CreateInstance(connectionType, connectionString) as DbConnection;
        }


        /// <summary>
        /// Creates and opens a connection instance
        /// </summary>
        /// <returns>the created and opened connection instance</returns>
        public static DbConnection CreateAndOpenConnection()
        {
            DbConnection connection = CreateConnection();
            if (ConnectionState.Open != connection.State)
            {
                connection.Open();
            }
            return connection;
        }


        /// <summary>
        /// Closes the given connection if not null
        /// </summary>
        /// <param name="connection">the connection to be closed</param>
        public static void CloseConnection(DbConnection connection)
        {
            if (connection == null)
            {
                return;
            }

            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Closes and disposes the given connection instance.
        /// </summary>
        /// <param name="connection">the connection isntance to be closed and disposed</param>
        public static void CloseDisposeConnection(DbConnection connection)
        {
            if (connection == null)
            {
                return;
            }

            try
            {
                CloseConnection(connection);
                connection.Dispose();
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Could not close and dispose connection", e);
            }
        }
    }
}
