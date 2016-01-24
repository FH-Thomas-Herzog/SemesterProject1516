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

        public IList<Artist> FindAllActive()
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
        public IList<Artist> FindAllFull()
        {
            IList<Artist> result = new List<Artist>();
            using (IDataReader reader = commandBuilder.WithQuery(" SELECT artist.*, g.id as group__id, g.name as group__name, c.id as category__id, c.name as category__name "
                                                               + " from ufo.artist as artist "
                                                               + " LEFT OUTER JOIN ufo.artist_group as g on g.id = artist.artist_group_id "
                                                               + " LEFT OUTER JOIN ufo.artist_category as c on c.id = artist.artist_category_id "
                                                               + " WHERE artist.deleted_flag = 0 "
                                                               + " ORDER BY CONCAT(artist.lastname, CONCAT(', ', artist.firstname))")
                                                     .ExecuteReader())
            {
                while (reader.Read())
                {
                    Artist artist = EntityBuilder.CreateFromReader<long?, Artist>(reader);
                    artist.ArtistGroup = EntityBuilder.CreateFromReader<long?, ArtistGroup>(reader, "group__");
                    artist.ArtistCategory = EntityBuilder.CreateFromReader<long?, ArtistCategory>(reader, "category__");
                    result.Add(artist);
                }
            }

            return result;
        }
    }
}
