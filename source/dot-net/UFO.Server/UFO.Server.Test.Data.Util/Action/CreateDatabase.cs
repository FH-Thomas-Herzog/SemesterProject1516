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
                AllowMultiple = false)]
    public class CreateDatabase : Attribute, ITestAction
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

        private void ExecuteScript(string fileName)
        {
            MySqlConnection connection = DbConnectionFactory.CreateAndOpenConnection<MySqlConnection>();
            string fullPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) + @"\Resources\" + fileName + ".sql";
            MySqlScript script = new MySqlScript(connection, File.ReadAllText(fullPath));
            script.Delimiter = ";";
            script.Execute();
        }
    }
}
