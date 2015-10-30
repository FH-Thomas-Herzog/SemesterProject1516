using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Test.Data.MYSql.Action
{
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class,
                AllowMultiple = false)]
    public class CreateDatabase : Attribute, ITestAction
    {
        public ActionTargets Targets { get { return ActionTargets.Default; } }

        public void AfterTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("After test will drop database");
        }

        public void BeforeTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("Creating database for tests");
        }
    }
}
