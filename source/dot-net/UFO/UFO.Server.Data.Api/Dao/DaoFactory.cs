using System;
using System.Configuration;
using System.Data.Common;
using System.Reflection;

namespace UFO.Server.Data.Api.Dao
{

    /// <summary>
    /// DaoFactory which produces the current available depeding dao implementations.
    /// </summary>
    public class DaoFactory
    {
        private static string assemblyName;
        private static Assembly assembly;

        private static string DAO_ASSEMBLY_PARAMETER = "DaoAssembly";


        /// <summary>
        /// Initializes the available assembly ones on static context initialization
        /// </summary>
        static DaoFactory()
        {
            assemblyName = ConfigurationManager.AppSettings[DAO_ASSEMBLY_PARAMETER];
            if (assemblyName == null)
            {
                throw new InvalidOperationException($"Assembly must provide app.config with set '{DAO_ASSEMBLY_PARAMETER}parameter");
            }
            assembly = Assembly.Load(assemblyName);
        }


        /// <summary>
        /// Creates the artist category DAO.
        /// </summary>
        /// <param name="connection">The connection.</param>
        /// <returns></returns>
        public static IArtistCategoryDao CreateArtistCategoryDao(DbConnection connection = null)
        {
            return CreateDao("ArtistCategoryDao") as IArtistCategoryDao;
        }

        /// <summary>
        /// Creates the artist DAO.
        /// </summary>
        /// <param name="connection">The connection.</param>
        /// <returns></returns>
        public static IArtistDao CreateArtistDao(DbConnection connection = null)
        {
            return CreateDao("ArtistDao") as IArtistDao;
        }

        /// <summary>
        /// Creates the artist group DAO.
        /// </summary>
        /// <param name="connection">The connection.</param>
        /// <returns></returns>
        public static IArtistGroupDao CreateArtistGroupDao(DbConnection connection = null)
        {
            return CreateDao("ArtistGroupDao") as IArtistGroupDao;
        }

        /// <summary>
        /// Creates the performance DAO.
        /// </summary>
        /// <param name="connection">The connection.</param>
        /// <returns></returns>
        public static IPerformanceDao CreatePerformanceDao(DbConnection connection = null)
        {
            return CreateDao("PerformanceDao") as IPerformanceDao;
        }

        /// <summary>
        /// Creates an instance of the IUserDao interface depending on the current available assembly
        /// </summary>
        /// <returns>the created instance</returns>
        public static IUserDao CreateUserDao(DbConnection connection = null)
        {
            return CreateDao("UserDao") as IUserDao;
        }

        /// <summary>
        /// Creates the venue DAO.
        /// </summary>
        /// <param name="connection">The connection.</param>
        /// <returns></returns>
        public static IVenueDao CreateVenueDao(DbConnection connection = null)
        {
            return CreateDao("VenueDao") as IVenueDao;
        }


        /// <summary>
        /// Creates the DAO.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="connection">The connection.</param>
        /// <returns></returns>
        /// <exception cref="System.InvalidOperationException"></exception>
        private static object CreateDao(string name, DbConnection connection = null)
        {
            try
            {
                Type type = assembly.GetType($"{assemblyName}.Dao.{name}");
                object[] arguments = { connection };
                return Activator.CreateInstance(type, arguments);
            }
            catch (System.Exception e)
            {
                throw new InvalidOperationException($"Dao with name '{name}' could not be instantiated", e);
            }
        }
    }
}
