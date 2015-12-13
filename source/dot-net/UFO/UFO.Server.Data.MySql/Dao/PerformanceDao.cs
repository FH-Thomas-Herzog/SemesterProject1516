using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Entity.View;

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

        public IList<PerformanceSummaryView> GetAllPerformanceSummaryViews()
        {
            IList<PerformanceSummaryView> views = new List<PerformanceSummaryView>();
            try
            {
                using (IDataReader reader = commandBuilder.WithQuery("SELECT DATE(start_date), COUNT(DISTINCT artist_id), COUNT(DISTINCT venue_id),COUNT(DATE(start_date)) FROM ufo.performance GROUP BY DATE(start_date)")
                                                          .ExecuteReader())
                {
                    while (reader.Read())
                    {
                        views.Add(new PerformanceSummaryView
                        {
                            Date = reader.GetDateTime(0),
                            ArtistCount = reader.GetInt32(1),
                            VenueCount = reader.GetInt32(2),
                            PerformanceCount = reader.GetInt32(3)
                        });
                    }
                }

                return views;
            }
            finally
            {
                commandBuilder.Clear();
            }
        }
    }
}
