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
        private readonly string DROP_SCRIPT = "dropDatabase";
        private readonly string CREATE_SCRIPT = "createDatabase";

        public ActionTargets Targets { get { return ActionTargets.Default; } }

        public void AfterTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("CreateDatabase#AfterTest(): '" + testDetails.FullName + "'");
            Console.Out.WriteLine("------------------------------------------------------------------------------");
            ExecuteScript(DROP_SCRIPT);
        }

        public void BeforeTest(TestDetails testDetails)
        {
            Console.Out.WriteLine("------------------------------------------------------------------------------");
            Console.Out.WriteLine("CreateDatabase#BeforeTest(): '" + testDetails.FullName + "'");
            try
            {
                ExecuteScript(DROP_SCRIPT);
            }
            catch (System.Exception e)
            {
                // No problem, just means databse does not exist
                Console.Out.WriteLine("CreateDatabase#BeforeTest(): No database existsto be dropped");
            }
            ExecuteScript(CREATE_SCRIPT);
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
