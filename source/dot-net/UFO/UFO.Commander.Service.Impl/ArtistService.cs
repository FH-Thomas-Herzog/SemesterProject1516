﻿using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Impl.Base;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Service.Impl
{
    public class ArtistService : BaseService, IArtistService
    {
        private IArtistDao artistDao;
        private IPerformanceDao performanceDao;

        public ArtistService(DbConnection connection = null) : base(connection)
        {
            artistDao = DaoFactory.CreateArtistDao(Connection);
            performanceDao = DaoFactory.CreatePerformanceDao(Connection);
        }

        public void Delete(long? id)
        {
            if (id == null)
            {
                throw new ArgumentException("Cannot delete artist with null id");
            }
            try
            {
                StartTx();
                performanceDao.DeleteAfter(id, DateTime.Now);
                if (performanceDao.ArtistHasPerformances(id))
                {
                    Artist artist = artistDao.ById(id);
                    artist.Deleted = true;
                    artistDao.Update(artist);
                }
                else {
                    artistDao.Delete(id);
                }
                CommitTx();
            }
            catch (Exception e)
            {
                RollbackTx();
            }
        }

        public Artist Save(Artist artist)
        {
            Artist artistDB = null;
            if (artist == null)
            {
                throw new ArgumentException("Cannot save null artist");
            }
            try
            {
                StartTx();
                if (artist.Id == null)
                {
                    artistDB = artistDao.Persist(artist);
                }
                else
                {
                    artistDB = artistDao.Update(artist);
                }
                CommitTx();
            }
            catch (Exception e)
            {
                RollbackTx();
            }

            return artistDB;
        }

        protected override void Dispose(bool dispose)
        {
            base.Dispose();
            DaoFactory.DisposeDao(artistDao);
        }
    }
}
