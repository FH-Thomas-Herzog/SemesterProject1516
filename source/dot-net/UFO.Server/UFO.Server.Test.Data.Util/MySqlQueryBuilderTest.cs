using System;
using NUnit.Framework;
using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Db;
using System.Data.Common;
using UFO.Server.Data.MySql.Db;
using UFO.Server.Test.Nunit.Api.Action;
using UFO.Server.Data.MySql.Entity;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.Util.MySql
{
    [TestFixture, CreateDatabase]
    public class MySqlQueryBuilderTest
    {
        [Test, CleanupDatabase]
        public void Test()
        {
            MySqlQueryBuilder<int, User> queryBuidler = new MySqlQueryBuilder<int, User>();
            try
            {
                String query = queryBuidler.Select("id")
                        .Select("creation_date")
                        .WhereEq("id", 1)
                        .WhereIn("creation_date", new DateTime(), new DateTime())
                        .Build();
                Console.Out.WriteLine(query);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message);
            }

        }
    }
}