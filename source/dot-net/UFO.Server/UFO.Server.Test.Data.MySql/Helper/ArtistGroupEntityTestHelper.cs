using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.MySql.Helper
{
    public class ArtistGroupEntityTestHelper : BaseMySqlEntityHelper<long?, ArtistGroup>
    {
        private UserEntityTestHelper userHelper = new UserEntityTestHelper();

        private int count = 0;
        private User user;

        public override void Init()
        {
            count++;
            userHelper.Init();

            User user = userHelper.CreateValidEntity();
            user.Username = "artistGroupHelper_" + count;
            user.Email = "artistGroupoHelper_" + count + "@helper.com";
            this.user = userHelper.Persist(user);
        }

        public override ArtistGroup CreateInvalidEntity()
        {
            ArtistGroup group = CreateValidEntity();
            group.Description = null;
            group.Name = null;

            return group;
        }

        public override ArtistGroup CreateValidEntity(bool setId = false, int idx = 0)
        {
            ArtistGroup group = new ArtistGroup();
            if (setId)
            {
                group.Id = 1;
            }
            group.Name = "GroupName_" + idx;
            group.Description = "Description_" + idx;
            group.CreationUserId = user.Id;
            group.ModificationUserId = user.Id;

            return group;
        }

        public override long? CreateInvalidId()
        {
            return -1;
        }

        public override ArtistGroup UpdateEntity(ArtistGroup entity)
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
