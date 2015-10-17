using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Entity
{
    /// <summary>
    /// This interface marks an class as an entity.
    /// </summary>
    /// <typeparam name="T">The type of the entity id</typeparam>
    public interface IEntity<T>
    {
        /// <summary>
        /// The entities id which uniquly identifies an data row with its mapped table.  
        /// </summary>
        T Id { get; set; }
    }
}
