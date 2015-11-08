using System;
using System.Configuration;
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
                throw new InvalidOperationException("Assembly must provide app.config with set " + DAO_ASSEMBLY_PARAMETER + " parameter");
            }
            assembly = Assembly.Load(assemblyName);
        }


        /// <summary>
        /// Creates an instance of the IArtistCategoryDao interface depending on the current available assembly
        /// </summary>
        /// <returns>the created instance</returns>
        public static IArtistCategoryDao CreateArtistCategoryDao()
        {
            return (IArtistCategoryDao)CreateDao("ArtistCategoryDao");
        }

        /// <summary>
        /// Creates an instance of the IArtistDao interface depending on the current available assembly
        /// </summary>
        /// <returns>the created instance</returns>
        public static IArtistDao CreateArtistDao()
        {
            return (IArtistDao)CreateDao("ArtistDao");
        }

        /// <summary>
        /// Creates an instance of the IArtistGroupDao interface depending on the current available assembly
        /// </summary>
        /// <returns>the created instance</returns>
        public static IArtistGroupDao CreateArtistGroupDao()
        {
            return (IArtistGroupDao)CreateDao("ArtistGroupDao");
        }

        /// <summary>
        /// Creates an instance of the IPerformanceDao interface depending on the current available assembly
        /// </summary>
        /// <returns>the created instance</returns>
        public static IPerformanceDao CreatePerformanceDao()
        {
            return (IPerformanceDao)CreateDao("PerformanceDao");
        }

        /// <summary>
        /// Creates an instance of the IUserDao interface depending on the current available assembly
        /// </summary>
        /// <returns>the created instance</returns>
        public static IUserDao CreateUserDao()
        {
            return (IUserDao)CreateDao("UserDao");
        }

        /// <summary>
        /// Creates an instance of the IVenueDao interface depending on the current available assembly
        /// </summary>
        /// <returns>the created instance</returns>
        public static IVenueDao CreateVenueDao()
        {
            return (IVenueDao)CreateDao("VenueDao");
        }


        /// <summary>
        /// Creates an instance for the given type name.
        /// It is expected that the given type defines an empty constructor for instantiation.
        /// </summary>
        /// <param name="name">the fully qualified type name</param>
        /// <returns></returns>
        private static object CreateDao(string name)
        {
            try
            {
                
                string databaseClassName = assemblyName + ".Dao." + name;
                Type dbClass = assembly.GetType(databaseClassName);

                return Activator.CreateInstance(dbClass);
            }
            catch (System.Exception e)
            {
                throw new InvalidOperationException("Dao with name '" + name + "' could not be instantiated", e);
            }
        }
    }
}
