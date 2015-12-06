﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Service.Api.Base
{
    public class ServiceFactory
    {
        private static ServiceFactory Factory { get; set; }

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

        private ServiceFactory()
        {

        }

        public static ServiceFactory getInstance()
        {
            if (Factory == null)
            {
                Factory = new ServiceFactory();
            }

            return Factory;
        }

        public ISecurityService getSecurityService()
        {
            return CreateService("SecurityService") as ISecurityService;
        }

        public void DisposeService<S>(S service) where S : BaseService
        {
            service?.Dispose();
        }

        private static object CreateService(string name)
        {
            if (assembly != null)
            {
                try
                {
                    string serviceClassName = $"{assemblyName}.{name}";
                    Type serviceClass = assembly.GetType(serviceClassName);

                    return Activator.CreateInstance(serviceClass);
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