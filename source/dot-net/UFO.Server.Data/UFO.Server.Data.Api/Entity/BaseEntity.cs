using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Entity
{
    /// <summary>
    /// This is the base class for all used entities.
    /// It implements hash and euquals which includes the entity id.
    /// </summary>
    /// <typeparam name="T">The type of the entity id</typeparam>
    public abstract class BaseEntity<T> : IEntity<T>
    {
        public T Id { get; set; }

        /// <summary>
        /// HashCode implementation which includes hold id in the hash code.
        /// If id is null then base.GetHashCode is called.
        /// </summary>
        /// <returns>the instance hash code</returns>
        public override int GetHashCode()
        {
            if (Id != null)
            {
                return (13 * 7) + Id.GetHashCode();
            }
            return base.GetHashCode();
        }

        /// <summary>
        /// Euqlas implementation which uses its hold id for equality check.
        /// If the id is null then instance check is applied.
        /// </summary>
        /// <param name="obj">The other object to check equality with this instance</param>
        /// <returns>true if the given object is euqal to this instance, false otherwise</returns>
        public override bool Equals(object obj)
        {
            // Type check
            if ((obj != null) && (obj.GetType() == this.GetType()))
            {
                BaseEntity<T> other = (BaseEntity<T>)obj;
                if (Id == null)
                {
                    // Use object id if boths ids are null
                    if (other.Id == null)
                    {
                        return base.Equals(other);
                    }
                }
                else
                {
                    // Both hold the same Id 
                    return Id.Equals(other.Id);
                }
            }
            return false;
        }
    }
}
