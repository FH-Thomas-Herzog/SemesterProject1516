using System;

namespace UFO.Server.Data.Api.Entity
{
    /// <summary>
    /// Marks an class as an versioned entity.
    /// </summary>
    /// <typeparam name="T">The type of the entity id</typeparam>
    public interface IVersionedEntity<I, T> : IEntity<I>
    {
        /// <summary>
        /// The date when this entity was created.
        /// </summary>
        DateTime CreationDate { get; set; }

        /// <summary>
        /// The user who created this entity.
        /// </summary>
        T CreationUserId { get; set; }

        /// <summary>
        /// The date when this entity was modified.
        /// </summary>
        DateTime ModificationDate { get; set; }

        /// <summary>
        /// The user who modified this entity last.
        /// </summary>
        T ModificationUserId { get; set; }

        /// <summary>
        /// The version of this entity.
        /// Will be increased by one on each update including the creation
        /// </summary>
        long? Version { get; set; }
    }
}
