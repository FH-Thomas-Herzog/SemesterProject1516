using System.Collections;
using System.Collections.Generic;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Dao
{
    public interface IArtistDao : IDao<long?, Artist>
    {
        IList<Artist> FindAllActive();

        IList<Artist> FindAllFull();
    }
}
