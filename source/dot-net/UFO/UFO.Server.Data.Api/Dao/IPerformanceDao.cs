using System;
using System.Collections;
using System.Collections.Generic;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Entity.View;

namespace UFO.Server.Data.Api.Dao
{
    public interface IPerformanceDao : IDao<long?, Performance>
    {
        int DeleteAfter(long? id, DateTime dateTime);

        bool ArtistHasPerformances(long? id);

        IList<PerformanceSummaryView> GetAllPerformanceSummaryViews();
    }
}
