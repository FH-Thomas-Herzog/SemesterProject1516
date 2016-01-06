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

        public bool ArtistHasPerformanceOnDate(long? artistId, DateTime startDate, DateTime endDate, long? performanceId)
        {
            try
            {
                return (commandBuilder.WithQuery(" SELECT DISTINCT(id) FROM ufo.performance "
                                               + " WHERE artist_id = ?artistId "
                                               + " AND id != ?performanceId "
                                               + " AND DATE(?startDate) = DATE(start_date) "
                                               + " AND TIME(end_date) > TIME(?startDate) "
                                               + " AND TIME(start_date) < TIME(?endDate) ")
                                      .SetParameter("?artistId", artistId)
                                      .SetParameter("?performanceId", performanceId)
                                      .SetParameter("?startDate", startDate)
                                      .SetParameter("?endDate", endDate)
                                      .ExecuteScalar() != null);
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
                using (IDataReader reader = commandBuilder.WithQuery(" SELECT performance.*, artist.id as artist__id, artist.firstname as artist__firstname, artist.lastname as artist__lastname, artistGroup.id artistGroup__id, artistGroup.name artistGroup__name, artistCategory.id as artistCategory__id, artistCategory.name as artistCategory__name, venue.id as venue__id, venue.name as venue__name "
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
                    while (reader.Read())
                    {
                        Performance performance = EntityBuilder.CreateFromReader<long?, Performance>(reader);
                        performance.Artist = EntityBuilder.CreateFromReader<long?, Artist>(reader, "artist__");
                        performance.Artist.ArtistGroup = EntityBuilder.CreateFromReader<long?, ArtistGroup>(reader, "artistGroup__");
                        performance.Artist.ArtistCategory = EntityBuilder.CreateFromReader<long?, ArtistCategory>(reader, "artistCategory__");
                        performance.Venue = EntityBuilder.CreateFromReader<long?, Venue>(reader, "venue__");
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


        public IDictionary<Artist, IList<Performance>> GetAllPerformancesForNotification()
        {
            IDictionary<Artist, IList<Performance>> map = new Dictionary<Artist, IList<Performance>>();
            try
            {
                IList<Performance> performances = new List<Performance>();
                using (IDataReader reader = commandBuilder.WithQuery(" SELECT performance.*, artist.id as artist__id, artist.email as artist__email, artist.country_code as artist__country_code, venue.id as venue__id, venue.name as venue__name "
                                                                   + " FROM ufo.performance performance "
                                                                   + " INNER JOIN ufo.artist as artist on performance.artist_id = artist.id "
                                                                   + " INNER JOIN ufo.venue as venue on performance.venue_id = venue.id "
                                                                   + " WHERE performance.start_date > ?date "
                                                                   + " ORDER BY artist.creation_date ASC, DATE(performance.start_date) ASC, TIME(performance.start_date) ASC")
                                                          .SetParameter("?date", DateTime.Now)
                                                          .ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Performance performance = EntityBuilder.CreateFromReader<long?, Performance>(reader);
                        performance.Artist = EntityBuilder.CreateFromReader<long?, Artist>(reader, "artist__");
                        performance.Venue = EntityBuilder.CreateFromReader<long?, Venue>(reader, "venue__");
                        if(!map.ContainsKey(performance.Artist))
                        {
                            map[performance.Artist] = new List<Performance>();
                        }
                        map[performance.Artist].Add(performance);
                    }

                    return map;
                }
            }
            finally
            {
                commandBuilder.Clear();
            }
        }


        public IList<Performance> GetFilteredPerformancesFull(DateTime startDate, DateTime endDate, IList<long?> artistIds, IList<long?> venueIds)
        {
            try
            {
                IList<Performance> performances = new List<Performance>();
                commandBuilder = commandBuilder.WithQuery(" SELECT performance.*, artist.id as artist__id, artist.firstname as artist__firstname, artist.lastname as artist__lastname, artistGroup.id artistGroup__id, artistGroup.name artistGroup__name, artistCategory.id as artistCategory__id, artistCategory.name as artistCategory__name, venue.id as venue__id, venue.name as venue__name "
                                                                   + " FROM ufo.performance performance "
                                                                   + " INNER JOIN ufo.artist as artist on performance.artist_id = artist.id "
                                                                   + " INNER JOIN ufo.artist_category as artistCategory on artist.artist_category_id = artistCategory.id "
                                                                   + " INNER JOIN ufo.artist_group as artistGroup on artist.artist_group_id = artistGroup.id "
                                                                   + " INNER JOIN ufo.venue as venue on performance.venue_id = venue.id "
                                                                   + " WHERE performance.start_date >= ?startDate "
                                                                   + " AND performance.end_date <= ?endDate "
                                                                   + (((venueIds != null) && (venueIds.Count > 0)) ? (" AND venue.id IN (?venueIds) ") : "")
                                                                   + (((artistIds != null) && (artistIds.Count > 0)) ? (" AND artist.id IN (?artistIds) ") : "")
                                                                   + " ORDER BY DATE(performance.start_date), TIME(performance.start_date)")
                                                          .SetParameter("?startDate", startDate)
                                                          .SetParameter("?endDate", endDate);
                if((artistIds != null) && (artistIds.Count > 0))
                {
                    commandBuilder.SetParameter("?artistIds", artistIds);
                }
                if ((venueIds != null) && (venueIds.Count > 0))
                {
                    commandBuilder.SetParameter("?venueIds", venueIds);
                }

                using (IDataReader reader = commandBuilder.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Performance performance = EntityBuilder.CreateFromReader<long?, Performance>(reader);
                        performance.Artist = EntityBuilder.CreateFromReader<long?, Artist>(reader, "artist__");
                        performance.Artist.ArtistGroup = EntityBuilder.CreateFromReader<long?, ArtistGroup>(reader, "artistGroup__");
                        performance.Artist.ArtistCategory = EntityBuilder.CreateFromReader<long?, ArtistCategory>(reader, "artistCategory__");
                        performance.Venue = EntityBuilder.CreateFromReader<long?, Venue>(reader, "venue__");
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
