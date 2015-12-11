using System;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Dao
{
    public interface IPerformanceDao : IDao<long?, Performance>
    {
        int DeleteAfter(long? id, DateTime dateTime);

        bool ArtistHasPerformances(long? id);
    }
}
