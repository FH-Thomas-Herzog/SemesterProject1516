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
    public abstract class BaseDbAction: Attribute
    {
        protected MySqlConnection connection = DbConnectionFactory.CreateAndOpenConnection<MySqlConnection>();

        ~BaseDbAction()
        {
            DbConnectionFactory.CloseDisposeConnection(connection);
        }
        
        protected void ExecuteScript(string fileName)
        {
            string fullPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location) + @"\Resources\" + fileName + ".sql";
            MySqlScript script = new MySqlScript(connection, File.ReadAllText(fullPath));
            script.Delimiter = ";";
            script.Execute();
        }
    }
}
