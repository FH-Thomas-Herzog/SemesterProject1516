﻿using FO.Server.Data.MySql.Dao;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.MySql.Db;
using UFO.Server.Data.Api.Entity;
using MySql.Data.MySqlClient;

namespace UFO.Server.Data.MySql.Dao
{
    public class ArtistGroupDao : MySqlBaseDao<long?, ArtistGroup>, IArtistGroupDao
    {
    }
}
