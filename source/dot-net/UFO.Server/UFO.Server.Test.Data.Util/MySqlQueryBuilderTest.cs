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
        public void TestSelect()
        {
            MySqlSelectQueryBuilder<int, User> queryBuidler = new MySqlSelectQueryBuilder<int, User>();
            try
            {
                String query = queryBuidler.Select("Id")
                        .Select("CreationDate")
                        .WhereEq("Id", 1)
                        .WhereEq("CreationDate", new DateTime())
                        .WhereEq("ModificationDate", new DateTime())
                        .WhereEq("ModificationDate", new DateTime())
                        .WhereIn("FirstName", "Thomas", "Rudi", "Franzi")
                        .ToQuery();
                Console.Out.WriteLine(query);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message);
            }

        }

        [Test, CleanupDatabase]
        public void TestSelectAll()
        {
            MySqlSelectQueryBuilder<int, User> queryBuidler = new MySqlSelectQueryBuilder<int, User>();
            try
            {
                String query = queryBuidler.SelectAll()
                                            .WhereEq("Id", 1)
                                            .WhereIn("FirstName", "Thomas", "Rudi", "Franzi")
                                            .ToQuery();
                Console.Out.WriteLine(query);
            }
            catch (Exception e)
            {
                Console.Out.WriteLine(e.Message);
            }

        }
    }
}