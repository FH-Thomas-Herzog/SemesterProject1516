﻿using System;
using System.Collections;
using System.Collections.Generic;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Entity.View;

namespace UFO.Server.Data.Api.Dao
{
    public interface IPerformanceDao : IDao<long?, Performance>
    {
        int DeleteAfter(long? id, DateTime dateTime);

        bool ArtistHasPerformances(long? id);

        bool ArtistHasPerformanceOnDate(long? artistId, DateTime startDate, DateTime endDate, long? performanceId);

        bool VenueHasPerformanceOnDate(long venueId, DateTime startDate, DateTime endDate, long? performanceId);

        IList<PerformanceSummaryView> GetAllPerformanceSummaryViews();

        IList<Performance> GetAllPerformancesFullForDay(DateTime date);

        IDictionary<Artist, IList<Performance>> GetAllPerformancesForNotification();

        IList<Performance> GetFilteredPerformancesForExport(long? venueId, DateTime startDate, DateTime endDate, IList<long?> artistIds, IList<long?> venueIds, IList<long?> artistGroupIds, IList<long?> artistCategoryIds, IList<string> countries, bool full, bool? moved);
    }
}
