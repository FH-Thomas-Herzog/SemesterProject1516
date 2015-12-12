using System;
using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using System.Data;
using UFO.Server.Data.Api.Db;
using System.Collections.Generic;

namespace UFO.Server.Data.MySql.Dao
{
    public class VenueDao : MySqlBaseDao<long?, Venue>, IVenueDao
    {
        public VenueDao(MySqlConnection connection = null) : base(connection) { }

        public IList<Venue> FindAllActive()
        {
            IList<Venue> result = new List<Venue>();
            using (IDataReader reader = commandBuilder.WithQuery("SELECT * from ufo.venue WHERE deleted_flag = 0 ORDER by UPPER(name)")
                                                     .ExecuteReader())
            {
                while (reader.Read())
                {
                    result.Add(EntityBuilder.CreateFromReader<long?, Venue>(reader));
                }
            }

            return result;
        }
        public bool IsVenueUsed(long? id)
        {
            if (id == null)
            {
                throw new ArgumentException("Cannot check for venue with null id");
            }
            object result = commandBuilder.WithQuery("Select DISTINCT(venue.id) from ufo.venue as venue INNER JOIN ufo.performance WHERE performance.venue_id = ?id")
                                          .SetParameter("?id", id)
                                          .ExecuteScalar();
            return (result != null);
        }
    }
}
