using MySql.Data.MySqlClient;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Test.Data.MySql.Action
{
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class |
                AttributeTargets.Interface | AttributeTargets.Assembly,
                AllowMultiple = true)]
    public class CleanupDatabase : Attribute, ITestAction
    {

        public ActionTargets Targets { get { return ActionTargets.Default; } }

        public void AfterTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("'Cleanup database after tests");
            ExecuteScript("deleteDatabase");
        }

        public void BeforeTest(TestDetails testDetails)
        {
        }

        private void ExecuteScript(string fileName)
        {
            MySqlConnection connection = (MySqlConnection)DbConnectionFactory.CreateAndOpenConnection();
            try
            {
                string fullPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) + @"\Resources\" + fileName + ".sql";
                MySqlScript script = new MySqlScript(connection, File.ReadAllText(fullPath));
                script.Delimiter = ";";
                script.Execute();
            }
            finally
            {
                DbConnectionFactory.CloseDisposeConnection(connection);
            }
        }
    }
}
