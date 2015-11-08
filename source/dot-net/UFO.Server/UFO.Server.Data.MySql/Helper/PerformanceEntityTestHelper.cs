using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Helper
{
    public class PerformanceEntityTestHelper : BaseMySqlEntityHelper<long?, Performance>
    {
        private UserEntityTestHelper userHelper = new UserEntityTestHelper();
        public ArtistEntityTestHelper artistHelper = new ArtistEntityTestHelper();
        private VenueEntityTestHelper venueHelper = new VenueEntityTestHelper();

        private int count = 0;
        private User user;
        private Venue venue;

        public override void Init()
        {
            count++;
            venueHelper.Init();

            this.venue = venueHelper.Persist(venueHelper.CreateValidEntity());
        }

        public override Performance CreateInvalidEntity()
        {
            Performance performance = CreateValidEntity();
            performance.StartDate = null;
            performance.EndDate = null;

            return performance;
        }

        public override Performance CreateValidEntity(bool setId = false, int idx = 0)
        {
            Performance performance = new Performance();
            if (setId)
            {
                performance.Id = 1;
            }
            performance.CreationUserId = venue.CreationUserId;
            performance.ModificationUserId = venue.ModificationUserId;
            performance.CreationUser = userHelper.LoadById(venue.CreationUserId);
            performance.ModificationUser = userHelper.LoadById(venue.ModificationUserId);
            performance.StartDate = new System.DateTime();
            performance.EndDate = new System.DateTime();
            performance.ArtistId = venue.ArtistId;
            performance.Artist = artistHelper.LoadById(venue.ArtistId);
            performance.VenueId = venue.Id;
            performance.Venue = venue;

            return performance;
        }

        public override long? CreateInvalidId()
        {
            return -1;
        }

        public override Performance UpdateEntity(Performance entity)
        {
            if (entity != null)
            {
                entity.StartDate.Value.AddDays(2);
                entity.EndDate.Value.AddDays(2);
            }

            return entity;
        }
    }
}
