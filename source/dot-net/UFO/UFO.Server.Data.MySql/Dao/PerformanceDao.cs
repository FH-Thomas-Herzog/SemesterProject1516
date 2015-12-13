using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
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

        public IList<Performance> GetAllPerformancesFullForDay(DateTime date)
        {
            if (date == null)
            {
                throw new ArgumentException("Date must not be null");
            }
            try
            {
                IList<Performance> performances = new List<Performance>();
                using (IDataReader reader = commandBuilder.WithQuery(" SELECT performance.*, artist.*, artistGroup.*, artistCategory.*, venue.* "
                                                                   + " FROM ufo.performance performance "
                                                                   + " INNER JOIN ufo.artist as artist on performance.artist_id = artist.id "
                                                                   + " INNER JOIN ufo.artist_category as artistCategory on artist.artist_category_id = artistCategory.id "
                                                                   + " INNER JOIN ufo.artist_group as artistGroup on artist.artist_group_id = artistGroup.id "
                                                                   + " INNER JOIN ufo.venue as venue on performance.venue_id = venue.id "
                                                                   + " WHERE DATE(performance.start_date) = DATE(?date) "
                                                                   + " ORDER BY DATE(performance.start_date), TIME(performance.start_date)")
                                                          .SetParameter("?date", date) 
                                                          .ExecuteReader())
                {
                    while(reader.Read())
                    {
                        Performance performance = EntityBuilder.CreateFromReader<long?, Performance>(reader, "performance");
                        performance.Artist = EntityBuilder.CreateFromReader<long?, Artist>(reader, "artist");
                        performance.Artist.ArtistGroup = EntityBuilder.CreateFromReader<long?, ArtistGroup>(reader, "artistGroup");
                        performance.Artist.ArtistCategory = EntityBuilder.CreateFromReader<long?, ArtistCategory>(reader, "artistCategory");
                        performance.Venue = EntityBuilder.CreateFromReader<long?, Venue>(reader, "venue");
                        performances.Add(performance);
                    }

                    return performances;
                }
            }
            finally
            {
                commandBuilder.Clear();
            }
        }
    }
}
