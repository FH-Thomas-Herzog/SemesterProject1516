using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.Data;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Dao
{
    public class ArtistGroupDao : MySqlBaseDao<long?, ArtistGroup>, IArtistGroupDao
    {
        public ArtistGroupDao(MySqlConnection connection = null) : base(connection) { }
        public IList<ArtistGroup> GetAll()
        {
            IList<ArtistGroup> result = new List<ArtistGroup>();
            using (IDataReader reader = commandBuilder.WithQuery("SELECT * FROM artist_group order by UPPER(name) DESC")
                          .ExecuteReader())
            {
                while (reader.Read())
                {
                    result.Add(EntityBuilder.CreateFromReader<long?, ArtistGroup>(reader));
                }
            }
            return result;
        }
    }
}
