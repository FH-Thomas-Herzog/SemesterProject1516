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
    public class ArtistDao : MySqlBaseDao<long?, Artist>, IArtistDao
    {
        public ArtistDao(MySqlConnection connection = null) : base(connection) { }

        public IList<Artist> GetAll()
        {
            IList<Artist> result = new List<Artist>();
            using (IDataReader reader = commandBuilder.WithQuery("SELECT * from ufo.artist WHERE deleted_flag = 0 ORDER by CONCAT(artist.lastname, CONCAT(', ', artist.firstname))")
                                                     .ExecuteReader())
            {
                while (reader.Read())
                {
                    result.Add(EntityBuilder.CreateFromReader<long?, Artist>(reader));
                }
            }

            return result;
        }
    }
}
