using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Common;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Service.Api.Base
{
    public class ServiceFactory
    {
        private static string assemblyName;
        private static Assembly assembly;

        private static string SERVICE_ASSEMBLY_PARAMETER = "ServiceAssembly";

        static ServiceFactory()
        {
            assemblyName = ConfigurationManager.AppSettings[SERVICE_ASSEMBLY_PARAMETER];
            if (assemblyName == null)
            {
                // Breaks desinger !!!
                //throw new InvalidOperationException($"Assembly must provide App.config with set {SERVICE_ASSEMBLY_PARAMETER} parameter");
            }
            else {
                assembly = Assembly.Load(assemblyName);
            }
        }

        private ServiceFactory() { }

        public static ISecurityService CreateSecurityService(DbConnection connection = null)
        {
            return CreateService("SecurityService", connection) as ISecurityService;
        }

        public static IUserService CreateUserService(DbConnection connection = null)
        {
            return CreateService("UserService", connection) as IUserService;
        }
        public static IArtistService CreateArtistService(DbConnection connection = null)
        {
            return CreateService("ArtistService", connection) as IArtistService;
        }
        public static void DisposeService(IService service)
        {
            service?.Dispose();
        }

        private static object CreateService(string name, DbConnection connection = null)
        {
            if (assembly != null)
            {
                try
                {
                    string serviceClassName = $"{assemblyName}.{name}";
                    Type serviceClass = assembly.GetType(serviceClassName);
                    object[] arguments = new object[1] { connection };

                    return Activator.CreateInstance(serviceClass, arguments);
                }
                catch (System.Exception e)
                {
                    throw new InvalidOperationException($"Service with name '{name}' could not be instantiated", e);
                }
            }
            return null;
        }
    }
}
