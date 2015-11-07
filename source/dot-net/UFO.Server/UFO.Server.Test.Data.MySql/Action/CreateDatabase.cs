using MySql.Data.MySqlClient;
using NUnit.Framework;
using System;
using System.IO;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Test.Data.MySql.Action
{
    /// <summary>
    /// TestAction for creating a test databasae for a test class or method
    /// </summary>
    [AttributeUsage(AttributeTargets.Method | AttributeTargets.Class,
                AllowMultiple = true)]
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

        /// <summary>
        /// Executes against the test database.
        /// </summary>
        /// <param name="fileName"></param>
        protected void ExecuteScript(string fileName)
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
