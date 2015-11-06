using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Data.Api.Dao
{
    public class DaoFactory
    {
        private static string assemblyName;
        private static Assembly assembly;

        static DaoFactory()
        {
            assemblyName = ConfigurationManager.AppSettings["DaoAssembly"];
            assembly = Assembly.Load(assemblyName);
        }

        public static IArtistCategoryDao CreateArtistCategoryDao()
        {
            return (IArtistCategoryDao)CreateDao("ArtistCategoryDao");
        }

        public static IArtistDao CreateArtistDao()
        {
            return (IArtistDao)CreateDao("ArtistDao");
        }

        public static IArtistGroupDao CreateArtistGroupDao()
        {
            return (IArtistGroupDao)CreateDao("ArtistGroupDao");
        }

        public static IPerformanceDao CreatePerformanceDao()
        {
            return (IPerformanceDao)CreateDao("PerformanceDao");
        }

        public static IUserDao CreateUserDao()
        {
            return (IUserDao)CreateDao("UserDao");
        }

        public static IVenueDao CreateVenueDao()
        {
            return (IVenueDao)CreateDao("VenueDao");
        }

        private static object CreateDao(string name)
        {
            string databaseClassName = assemblyName + ".Dao." + name;
            Type dbClass = assembly.GetType(databaseClassName);

            return Activator.CreateInstance(dbClass);
        }
    }
}
