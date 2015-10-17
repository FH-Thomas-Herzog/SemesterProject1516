using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Entity
{
    /// <summary>
    /// This class is the base class for all versioned entity.
    /// </summary>
    /// <typeparam name="T">The type of the entity id</typeparam>
    public abstract class BaseVersionedEntity<T> : BaseEntity<T>, IVersionedEntity<T>
    {
        public DateTime creationDate { get; set; }

        public int CreationUserId { get; set; }

        public DateTime modificationDate { get; set; }

        public int ModificationUserId { get; set; }

        public long Version { get; set; }
    }
}
