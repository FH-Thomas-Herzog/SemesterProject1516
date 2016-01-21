using FO.Server.Data.MySql.Dao;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
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

        public bool VenueHasPerformanceOnDate(long venueId, DateTime startDate, DateTime endDate, long? performanceId)
        {
            try
            {
                return (commandBuilder.WithQuery(" SELECT DISTINCT(id) FROM ufo.performance "
                                               + " WHERE id != ?performanceId "
                                               + " AND start_date = ?startDate "
                                               + " AND end_date = ?endDate "
                                               + " AND venue_id = ?venueId ")
                                      .SetParameter("?performanceId", performanceId)
                                      .SetParameter("?startDate", startDate)
                                      .SetParameter("?endDate", endDate)
                                      .SetParameter("?venueId", venueId)
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
                        if (!map.ContainsKey(performance.Artist))
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


        public IList<Performance> GetFilteredPerformancesForExport(long? venueId, DateTime startDate, DateTime endDate, IList<long?> artistIds, IList<long?> venueIds, IList<long?> artistGroupIds, IList<long?> artistCategoryIds, IList<string> countries, bool full, bool? moved)
        {
            try
            {
                IList<Performance> performances = new List<Performance>();
                commandBuilder = commandBuilder.WithQuery(" SELECT performance.*, artist.id as artist__id, artist.firstname as artist__firstname, artist.lastname as artist__lastname, artist.country_code as artist__country_code, artist.artist_category_id as artist__artist_category_id, artist.artist_group_id as artist__artist_group_id, "
                                                        + " artistGroup.id artistGroup__id, artistGroup.name artistGroup__name, "
                                                        + " artistCategory.id as artistCategory__id, artistCategory.name as artistCategory__name, "
                                                        + " venue.id as venue__id, venue.name as venue__name, "
                                                        + " former_venue.id as former_venue__id, former_venue.name as former_venue__name "
                                                        + (full ? ", venue.description as venue__description, venue.street as venue__street, venue.zip as venue__zip, venue.city as venue__city, venue.gps_coordinate as venue__gps_coordinate " : "")
                                                        + " FROM ufo.performance performance "
                                                        + " INNER JOIN ufo.artist as artist on performance.artist_id = artist.id "
                                                        + " INNER JOIN ufo.artist_category as artistCategory on artist.artist_category_id = artistCategory.id "
                                                        + $"{(((artistGroupIds != null) && (artistGroupIds.Count > 0)) ? "INNER" : "LEFT OUTER")} JOIN ufo.artist_group as artistGroup on artist.artist_group_id = artistGroup.id "
                                                        + " INNER JOIN ufo.venue as venue on performance.venue_id = venue.id "
                                                        + " LEFT OUTER JOIN ufo.venue as former_venue on performance.former_venue_id = former_venue.id "
                                                        + " WHERE performance.start_date >= ?startDate "
                                                        + " AND performance.end_date <= ?endDate "
                                                        + ((moved != null) ? $" AND performance.former_start_date IS {((moved.Value) ? "NOT" : "")} NULL" : "")
                                                        + ((venueId != null) ? " AND venue.id = ?venueId " : "")
                                                        + (((venueIds != null) && (venueIds.Count > 0)) ? ($" AND venue.id IN ({string.Join(",", Enumerable.Range(0, venueIds.Count).Select(i => $"?venue_id_{i}"))}) ") : "")
                                                        + (((artistIds != null) && (artistIds.Count > 0)) ? ($" AND artist.id IN ({string.Join(",", Enumerable.Range(0, artistIds.Count).Select(i => $"?artist_id_{i}"))}) ") : "")
                                                        + (((countries != null) && (countries.Count > 0)) ? ($" AND UPPER(artist.country_code) IN ({string.Join(",", Enumerable.Range(0, countries.Count).Select(i => $"?artist_country_code_{i}"))}) ") : "")
                                                        + (((artistGroupIds != null) && (artistGroupIds.Count > 0)) ? ($" AND artistGroup.id IN ({string.Join(",", Enumerable.Range(0, artistGroupIds.Count).Select(i => $"?artistGroup_id_{i}"))}) ") : "")
                                                        + (((artistCategoryIds != null) && (artistCategoryIds.Count > 0)) ? ($" AND artistCategory.id IN ({string.Join(",", Enumerable.Range(0, artistCategoryIds.Count).Select(i => $"?artistCategory_id_{i}"))}) ") : "")
                                                        + " ORDER BY performance.start_date")
                                                          .SetParameter("?startDate", startDate)
                                                          .SetParameter("?endDate", endDate);
                if (venueId != null)
                {
                    commandBuilder.SetParameter("?venueId", venueId);
                }
                if ((artistIds != null) && (artistIds.Count > 0))
                {
                    for (int i = 0; i < artistIds.Count; i++)
                    {
                        commandBuilder.SetParameter($"?artist_id_{i}", artistIds.ElementAt(i));
                    }
                }
                if ((venueIds != null) && (venueIds.Count > 0))
                {
                    for (int i = 0; i < venueIds.Count; i++)
                    {
                        commandBuilder.SetParameter($"?venue_id_{i}", venueIds.ElementAt(i));
                    }
                }
                if ((artistGroupIds != null) && (artistGroupIds.Count > 0))
                {
                    for (int i = 0; i < artistGroupIds.Count; i++)
                    {
                        commandBuilder.SetParameter($"?artistGroup_id_{i}", artistGroupIds.ElementAt(i));
                    }
                }
                if ((artistCategoryIds != null) && (artistCategoryIds.Count > 0))
                {
                    for (int i = 0; i < artistCategoryIds.Count; i++)
                    {
                        commandBuilder.SetParameter($"?artistCategory_id_{i}", artistCategoryIds.ElementAt(i));
                    }
                }
                if ((countries != null) && (countries.Count > 0))
                {
                    for (int i = 0; i < countries.Count; i++)
                    {
                        commandBuilder.SetParameter($"?artist_country_code_{i}", countries.ElementAt(i).ToUpper());
                    }
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
                        performance.FormerVenue = EntityBuilder.CreateFromReader<long?, Venue>(reader, "former_venue__");
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
