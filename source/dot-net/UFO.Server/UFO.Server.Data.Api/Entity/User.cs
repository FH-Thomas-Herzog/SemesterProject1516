using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api;
using UFO.Server.Data.Api.Attribute;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Entity
{
    [Api.Attribute.Entity(TableName = "user",
                          Schema = "ufo")]
    public class User : BaseVersionedEntity<long?, User, long?>
    {
        [Id(PkType = PkType.AUTO)]
        [Column(Name = "id", ReadOnly = true)]
        public override long? Id { get; set; }

        [Column(Name = "firstname")]
        public string FirstName { get; set; }

        [Column(Name = "lastname")]
        public string LastName { get; set; }

        [Column(Name = "username")]
        public string Username { get; set; }

        [Column(Name = "email")]
        public string Email { get; set; }
    }
}
