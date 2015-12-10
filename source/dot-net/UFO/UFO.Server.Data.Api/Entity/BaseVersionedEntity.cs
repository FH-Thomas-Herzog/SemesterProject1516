using System;
using UFO.Server.Data.Api.Attribute;

namespace UFO.Server.Data.Api.Entity
{
    /// <summary>
    /// This class is the base class for all versioned entity.
    /// </summary>
    /// <typeparam name="T">The type of the entity id</typeparam>
    /// <typeparam name="O">The type of the owner which is normaly a user</typeparam>
    /// <typeparam name="I">The type of the owner id</typeparam>
    public abstract class BaseVersionedEntity<T, O, I> : BaseEntity<I>, IModifyableEntity<I, T> where O : class, IEntity<T>
    {
        [Column(Name = "creation_date", ReadOnly = true)]
        public DateTime CreationDate { get; set; }

        [Column(Name = "creation_user_id")]
        public T CreationUserId { get; set; }

        [Column(Name = "modification_date", ReadOnly = true)]
        public DateTime ModificationDate { get; set; }

        [Column(Name = "modification_user_id")]
        public T ModificationUserId { get; set; }

        [Column(Name = "version", ReadOnly = true, Version = true)]
        public long? Version { get; set; }

        [ManyToOne(FkProperty = "CreationUserId")]
        public O CreationUser { get; set; }

        [ManyToOne(FkProperty = "ModificationUserId")]
        public O ModificationUser { get; set; }
    }
}
