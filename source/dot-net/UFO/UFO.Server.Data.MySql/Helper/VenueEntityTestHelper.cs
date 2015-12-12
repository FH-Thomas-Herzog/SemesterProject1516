using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Helper
{
    public class VenueEntityTestHelper : BaseMySqlEntityHelper<long?, Venue>
    {
        private UserEntityTestHelper userHelper = new UserEntityTestHelper();

        private User user;
        private int count = 0;

        public override void Init()
        {
            count++;
            userHelper.Init();

            user = userHelper.Persist(userHelper.CreateValidEntity());
        }

        public override Venue CreateInvalidEntity()
        {
            Venue venue = CreateValidEntity();
            venue.Description = null;
            venue.Name = null;

            return venue;
        }

        public override Venue CreateValidEntity(bool setId = false, int idx = 0)
        {
            Venue venue = new Venue();
            if (setId)
            {
                venue.Id = 1;
            }
            venue.CreationUserId = user.Id;
            venue.ModificationUserId = user.Id;
            venue.CreationUser = user;
            venue.ModificationUser = user;
            venue.Name = "VenueName";
            venue.Description = "VenueDescription";
            venue.GpsCoordinate = "12341324:1324123";
            venue.Street = "venueStreet";
            venue.Zip = "venueZip";
            venue.City = "CITY";
            venue.Deleted = false;

            return venue;
        }

        public override long? CreateInvalidId()
        {
            return -1;
        }

        public override Venue UpdateEntity(Venue entity)
        {
            if (entity != null)
            {
                entity.Name += "_updated";
                entity.Description += "_updated";
            }

            return entity;
        }
    }
}
