using MySql.Data.MySqlClient;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Test.Data.MySql.Action
{
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class,
                AllowMultiple = true)]
    public class CreateDatabase : BaseDbAction, ITestAction
    {
        public ActionTargets Targets { get { return ActionTargets.Default; } }
        

        public void AfterTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("'Dropping database after tests");
            ExecuteScript("dropDatabase");
        }

        public void BeforeTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("Creating database for tests");
            ExecuteScript("createDatabase");
        }
    }
}
