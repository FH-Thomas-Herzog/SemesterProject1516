using System;
using System.Collections.Generic;
using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using System.Data;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Data.MySql.Dao
{
    public class ArtistCategoryDao : MySqlBaseDao<long?, ArtistCategory>, IArtistCategoryDao
    {
        public ArtistCategoryDao(MySqlConnection connection = null) : base(connection) { }

        public IList<ArtistCategory> GetAll()
        {
            IList<ArtistCategory> result = new List<ArtistCategory>();
            using (IDataReader reader = commandBuilder.WithQuery("SELECT * FROM artist_category order by UPPER(name) DESC")
                          .ExecuteReader())
            {
                while (reader.Read())
                {
                    result.Add(EntityBuilder.CreateFromReader<long?, ArtistCategory>(reader));
                }
            }
            return result;
        }
    }
}
