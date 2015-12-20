using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Impl.Base;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;

namespace UFO.Commander.Service.Impl
{
    public class VenueService : BaseService, IVenueService
    {
        private IVenueDao venueDao;

        public VenueService(DbConnection connection = null) : base(connection)
        {
            venueDao = DaoFactory.CreateVenueDao(connection);
        }

        public void Delete(long? id)
        {
            if (id == null)
            {
                throw new ArgumentException("Cannot delete venue with null id");
            }
            try
            {
                StartTx();
                if (venueDao.IsVenueUsed(id))
                {
                    Venue venue = venueDao.ById(id);
                    venue.Deleted = true;
                    venueDao.Update(venue);
                }
                else
                {
                    venueDao.Delete(id);
                }
                CommitTx();
            }
            catch (Exception e)
            {
                RollbackTx();
                throw e;
            }
        }

        public Venue Save(Venue venue)
        {
            if (venue == null)
            {
                throw new ArgumentException("Cannot save null venue");
            }
            try
            {
                StartTx();
                Venue venueDb = null;
                if (venue.Id == null)
                {
                    venueDb = venueDao.Persist(venue);
                }
                else {
                    if (venueDao.IsVenueUsed(venue.Id))
                    {
                        venueDb = venueDao.ById(venue.Id);
                        if (venueDb.Deleted)
                        {
                            throw new EntityNotFoundException();
                        }
                        if (!venueDb.Version.Equals(venue.Version))
                        {
                            throw new ConcurrentUpdateException("Venue has been updated by another user");
                        }
                        venueDb.Name = venue.Name;
                        venueDb = venueDao.Update(venueDb);
                    }
                    else
                    {
                        venueDb = venueDao.Update(venue);
                    }
                }
                CommitTx();

                return venueDb;
            }
            catch (Exception e)
            {
                RollbackTx();
                throw e;
            }
        }

        protected override void Dispose(bool dispose)
        {
            DaoFactory.DisposeDao(venueDao);
        }
    }
}
