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
    public class DataSourceFactory
    {
        private static string assemblyName;
        private static Type dataSourceType;
        private static Assembly assembly;
        private static string connectionString;

        private const string DB_ASSEMBLY = "DaoAssembly";
        private const string DATA_SOURCE_TYPE = "DbProviderAssemblyDataSourceType";
        private const string CONNECTION_STRING = "UFODB";


        /// <summary>
        /// Initializes the DbConnectionFactory by loading the available assembly and connection type 
        /// for creation.
        /// The pooling should be performed via the underlying db provider which normally pools the 
        /// underlying connection to the database and not the connection type instances
        /// </summary>
        static DataSourceFactory()
        {
            assemblyName = ConfigurationManager.AppSettings[DB_ASSEMBLY];
            if (assemblyName == null)
            {
                throw new InvalidOperationException($"Parameter '{DB_ASSEMBLY}' not set in app.config");
            }
            string conTypeNamePart = ConfigurationManager.AppSettings[DATA_SOURCE_TYPE];
            if (conTypeNamePart == null)
            {
                throw new InvalidOperationException($"Parameter '{DATA_SOURCE_TYPE}' not set in app.config");
            }
            string connectionTypeName = assemblyName + "." + conTypeNamePart;
            connectionString = ConfigurationManager.ConnectionStrings[CONNECTION_STRING].ConnectionString;
            if (connectionString == null)
            {
                throw new InvalidOperationException($"Parameter '{CONNECTION_STRING}' not set in app.config");
            }

            assembly = Assembly.Load(assemblyName);
            dataSourceType = assembly.GetType(connectionTypeName);
        }

        public static IDataSource CreateDataSource()
        {
            return Activator.CreateInstance(dataSourceType, new object[1] { connectionString }) as IDataSource;
        }

    }
}
