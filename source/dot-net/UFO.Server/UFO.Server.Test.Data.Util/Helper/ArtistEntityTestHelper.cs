using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Dao;
using UFO.Server.Test.Data.MySql.Dao;

namespace UFO.Server.Test.Data.MySql.Helper
{
    public class ArtistEntityTestHelper : BaseEntityTestHelper<long?, Artist>
    {
        private UserEntityTestHelper userHelper = new UserEntityTestHelper();
        private ArtistGroupEntityTestHelper artistGroupHelper = new ArtistGroupEntityTestHelper();
        private ArtistCategoryEntityTestHelper artistCategoryHelper = new ArtistCategoryEntityTestHelper();
        private UserDao userDao = new UserDao();
        private ArtistGroupDao artistGroupDao = new ArtistGroupDao();
        private ArtistCategoryDao artistCategoryDao = new ArtistCategoryDao();

        private int count = 0;
        private User user;
        private ArtistGroup artistGroup;
        private ArtistCategory artistCategory;

        public override void Init()
        {
            count++;
            User user = userHelper.CreateValidEntity();
            user.Username = "artistHelper_" + count;
            user.Email = "artistHelper_" + count + "@helper.com";
            this.user = userDao.Persist(user);

            this.artistGroup = artistGroupDao.Persist(artistGroupHelper.CreateValidEntity());

            this.artistCategory = artistCategoryDao.Persist(artistCategoryHelper.CreateValidEntity());
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
            Init();
            Artist artist = new Artist();
            if (setId)
            {
                artist.Id = 1;
            }
            artist.CountryCode = "de_DE";
            artist.Email = "master_" + idx + "@masterhood.at";
            artist.Firstname = "Thomas_" + idx + "";
            artist.Lastname = "Herzog_" + idx + "";
            artist.CreationUserId = user.Id;
            artist.ModificationUserId = user.Id;
            artist.ArtistGroupId = artistGroup.Id;
            artist.ArtistCategoryId = artistCategory.Id;

            return artist;
        }

        public override long? getInvalidId()
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
