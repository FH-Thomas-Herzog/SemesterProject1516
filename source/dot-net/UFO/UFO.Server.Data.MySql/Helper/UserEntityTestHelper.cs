using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Helper
{
    public class UserEntityTestHelper : BaseMySqlEntityHelper<long?, User>
    {
        public override void Init()
        {
        }

        public override User CreateInvalidEntity()
        {
            User user = new User();
            user.FirstName = "Hugo";
            user.LastName = null;
            user.Username = "cchet";
            user.Email = "cchet@masterhood.at";
            user.CreationUserId = null;
            user.ModificationUserId = null;
            user.Password = "MyEncryptedPasswort";

            return user;
        }

        public override User CreateValidEntity(bool setId = false, int idx = 0)
        {
            User user = new User();
            user.Id = (setId) ? ((long?)1) : null;
            user.FirstName = "Hugo";
            user.LastName = "Masterhood";
            user.Username = "cchet_" + idx;
            user.Email = "cchet_" + idx + "@masterhood.at";
            user.CreationUserId = null;
            user.ModificationUserId = null;
            user.Password = "MyEncryptedPasswort";
            user.Type = User.UserType.ADMINISTRATOR;

            return user;
        }

        public override long? CreateInvalidId()
        {
            return -1;
        }

        public override User UpdateEntity(User entity)
        {
            if (entity != null)
            {
                entity.FirstName += "firstname_updated";
                entity.LastName += "firstname_updated";
                entity.Username += "username_updated";
            }

            return entity;
        }
    }
}
