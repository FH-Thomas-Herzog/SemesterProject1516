using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.MySql.Helper
{
    public class ArtistEntityTestHelper : BaseMySqlEntityHelper<long?, Artist>
    {
        private UserEntityTestHelper userHelper = new UserEntityTestHelper();
        private ArtistGroupEntityTestHelper artistGroupHelper = new ArtistGroupEntityTestHelper();
        private ArtistCategoryEntityTestHelper artistCategoryHelper = new ArtistCategoryEntityTestHelper();

        private int count = 0;
        private ArtistGroup artistGroup;
        private ArtistCategory artistCategory;

        public override void Init()
        {
            count++;
            artistGroupHelper.Init();
            artistCategoryHelper.Init();

            this.artistGroup = artistGroupHelper.Persist(artistGroupHelper.CreateValidEntity());

            this.artistCategory = artistCategoryHelper.Persist(artistCategoryHelper.CreateValidEntity());
        }

        public override Artist CreateInvalidEntity()
        {
            Artist artist = CreateValidEntity();
            artist.Firstname = null;
            artist.Lastname = null;

            return artist;
        }

        public override Artist CreateValidEntity(bool setId = false, int idx = 0)
        {
            Artist artist = new Artist();
            if (setId)
            {
                artist.Id = 1;
            }
            artist.CountryCode = "de_DE";
            artist.Email = "master_" + idx + "@masterhood.at";
            artist.Firstname = "Thomas_" + idx + "";
            artist.Lastname = "Herzog_" + idx + "";
            artist.CreationUserId = artistGroup.CreationUserId;
            artist.ModificationUserId = artistGroup.ModificationUserId;
            artist.CreationUser = userHelper.LoadById(artistGroup.CreationUserId);
            artist.ModificationUser = userHelper.LoadById(artistGroup.ModificationUserId);
            artist.ArtistGroupId = artistGroup.Id;
            artist.ArtistCategoryId = artistCategory.Id;
            artist.ArtistGroup = artistGroup;
            artist.ArtistCategory = artistCategory;

            return artist;
        }

        public override long? CreateInvalidId()
        {
            return -1;
        }

        public override Artist UpdateEntity(Artist entity)
        {
            if (entity != null)
            {
                entity.Firstname += "_updated";
                entity.Lastname += "_updated";
            }

            return entity;
        }
    }
}
