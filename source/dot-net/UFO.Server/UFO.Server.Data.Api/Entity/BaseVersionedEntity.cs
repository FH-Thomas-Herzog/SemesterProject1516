using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Attribute;

namespace UFO.Server.Data.Api.Entity
{
    /// <summary>
    /// This class is the base class for all versioned entity.
    /// </summary>
    /// <typeparam name="T">The type of the entity id</typeparam>
    public abstract class BaseVersionedEntity<T> : BaseEntity<T>, IVersionedEntity<T>
    {
        [Column(Name = "creation_date")]
        public DateTime CreationDate { get; set; }

        [Column(Name = "creation_user_id")]
        public int CreationUserId { get; set; }

        [Column(Name = "modification_date")]
        public DateTime ModificationDate { get; set; }

        [Column(Name = "modification_user_id")]
        public int ModificationUserId { get; set; }

        [Column(Name = "version")]
        public long Version { get; set; }
    }
}
