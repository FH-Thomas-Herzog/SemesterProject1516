using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.MySql.Entity
{
    [Api.Attribute.Entity(TableName = "user",
                          SequenceName = "seq_user_id",
                          Schema = "ufo")]
    public class User : BaseVersionedEntity<int>
    {
    }
}
