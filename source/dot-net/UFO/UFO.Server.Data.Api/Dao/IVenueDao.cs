using System.Collections.Generic;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Dao
{
    public interface IVenueDao : IDao<long?, Venue>
    {
        IList<Venue> FindAllActive();
        bool IsVenueUsed(long? id);
    }
}
