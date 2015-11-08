using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Helper
{
    public class VenueEntityTestHelper : BaseMySqlEntityHelper<long?, Venue>
    {
        private UserEntityTestHelper userHelper = new UserEntityTestHelper();
        private ArtistEntityTestHelper artistHelper = new ArtistEntityTestHelper();

        private int count = 0;
        private Artist artist;

        public override void Init()
        {
            count++;
            artistHelper.Init();

            artist = artistHelper.Persist(artistHelper.CreateValidEntity());
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
            venue.CountryCode = "de_DE";
            venue.CreationUserId = artist.CreationUserId;
            venue.ModificationUserId = artist.ModificationUserId;
            venue.CreationUser = userHelper.LoadById(artist.CreationUserId);
            venue.ModificationUser = userHelper.LoadById(artist.ModificationUserId);
            venue.Name = "VenueName";
            venue.Description = "VenueDescription";
            venue.GpsCoordinate = "12341324:1324123";
            venue.Street = "venueStreet";
            venue.Zip = "venueZip";
            venue.ArtistId = artist.Id;
            venue.Artist = artist;

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
