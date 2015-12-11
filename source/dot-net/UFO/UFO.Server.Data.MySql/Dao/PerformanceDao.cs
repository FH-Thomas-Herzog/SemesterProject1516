using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using System;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Dao
{
    public class PerformanceDao : MySqlBaseDao<long?, Performance>, IPerformanceDao
    {
        public PerformanceDao(MySqlConnection connection = null) : base(connection) { }

        public int DeleteAfter(long? id, DateTime dateTime)
        {
            if ((id == null) || (dateTime == null))
            {
                throw new ArgumentException("Artist id and DateTime must not be null");
            }
            try
            {
                return commandBuilder.WithQuery("DELETE FROM ufo.performance WHERE end_date >= ?dateTime AND artist_id = ?id")
                          .SetParameter("?dateTime", dateTime)
                          .SetParameter("?id", id)
                          .ExecuteNonQuery();
            }
            finally
            {
                commandBuilder.Clear();
            }
        }

        public bool ArtistHasPerformances(long? id)
        {
            if (id == null)
            {
                throw new ArgumentException("Cannot check for performances for null artist id");
            }
            try
            {
                return ((long)commandBuilder.WithQuery("SELECT COUNT(id) FROM ufo.performance WHERE artist_id = ?id")
                                            .SetParameter("?id", id)
                                            .ExecuteScalar() > 0);
            }
            finally
            {
                commandBuilder.Clear();
            }
        }

    }
}
