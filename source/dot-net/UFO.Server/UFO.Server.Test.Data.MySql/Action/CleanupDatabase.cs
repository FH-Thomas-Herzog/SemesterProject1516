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
        private readonly string DELETE_SCRIPT = "deleteDatabase";

        public ActionTargets Targets { get { return ActionTargets.Default; } }

        public void AfterTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("CleanupDatabase#AfterTest(): '" + testDetails.Method.Name + "'");
            ExecuteScript(DELETE_SCRIPT);
        }

        public void BeforeTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("CleanupDatabase#BeforeTest(): '" + testDetails.Method.Name + "'");
            // We cannot clear database before because tests setUp method has already been called
            // which could already have interacted with the db.
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
