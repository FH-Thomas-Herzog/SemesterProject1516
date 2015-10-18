using System;
using NUnit.Framework;
using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Db;
using System.Data.Common;
using UFO.Server.Data.MySql.Db;
using UFO.Server.Test.Nunit.Api.Action;

namespace UFO.Server.Test.Data.Util.MySql
{
    [TestFixture, CreateDatabase]
    public class DbCommandBuilderTest
    {
        [Test, CleanupDatabase]
        public void test()
        {
            string query = "select * from user where id = @id";
            MySqlDbCommandBuilder builder = new MySqlDbCommandBuilder();
            MySqlCommand command = builder.WithTypeResolver(new MySqlDbTypeResolver())
                                          .WithConnection(new MySqlDbConnection())
                                          .Start(query)
                                          .SetParameter("@id", 14)
                                          .Build();

            Assert.AreEqual(query, command.CommandText);
            Assert.AreEqual(1, command.Parameters.Count);
        }
    }
}