using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Test.Nunit.Api.Action
{
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class |
                AttributeTargets.Interface | AttributeTargets.Assembly,
                AllowMultiple = true)]
    public class CreateDatabase : Attribute, ITestAction
    {
        public ActionTargets Targets { get { return ActionTargets.Default; } }

        public void AfterTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("After test will drop database");
        }

        public void BeforeTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("Before test will create database");
        }
    }
}
