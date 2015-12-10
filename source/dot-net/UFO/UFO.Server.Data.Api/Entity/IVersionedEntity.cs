using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Entity
{
    public interface IVersionedEntity
    {

        /// <summary>
        /// The version of this entity.
        /// Will be increased by one on each update including the creation
        /// </summary>
        long? Version { get; set; }
    }
}
