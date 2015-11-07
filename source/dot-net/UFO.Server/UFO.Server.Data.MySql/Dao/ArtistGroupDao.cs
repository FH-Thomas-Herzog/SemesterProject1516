﻿using FO.Server.Data.MySql.Dao;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Dao
{
    public class ArtistGroupDao : MySqlBaseDao<long?, ArtistGroup>, IArtistGroupDao
    {
    }
}
