using UFO.Server.Data.Api.Attribute;

namespace UFO.Server.Data.Api.Entity
{
    [Api.Attribute.Entity(TableName = "user",
                          Schema = "ufo")]
    public class User : BaseVersionedEntity<long?, User, long?>
    {
        public enum UserType { ADMINISTRATOR = 0, ARTIST = 1, EXTERNAL = 2 }

        [Id(PkType = PkType.AUTO)]
        [Column(Name = "id", ReadOnly = true)]
        public override long? Id { get; set; }

        [Column(Name = "firstname")]
        public string FirstName { get; set; }

        [Column(Name = "lastname")]
        public string LastName { get; set; }

        [Column(Name = "username")]
        public string Username { get; set; }
        [Column(Name = "password")]
        public string Password { get; set; }

        [Column(Name = "email")]
        public string Email { get; set; }

        [Column(Name = "user_type")]
        public UserType? Type { get; set; }
    }
}
