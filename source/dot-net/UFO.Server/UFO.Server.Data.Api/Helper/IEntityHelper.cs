using System.Collections.Generic;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api
{
    /// <summary>
    /// This interface specifies an entity helper which provides entity instance for an given type
    /// </summary>
    /// <typeparam name="I">the type of the entity id</typeparam>
    /// <typeparam name="E">the type of the entity</typeparam>
    public interface IEntityHelper<I, E> where E : class, IEntity<I>
    {

        /// <summary>
        /// Initializes this helper instance
        /// </summary>
        void Init();

        /// <summary>
        /// Creates a valid entity instance.
        /// </summary>
        /// <param name="setId">true if an id should be set</param>
        /// <param name="idx">the index added to entity fields for iteration creation</param>
        /// <returns></returns>
        E CreateValidEntity(bool setId = false, int idx = 0);

        /// <summary>
        /// Creates an invalid entity instance
        /// </summary>
        /// <returns>the created invalid entity instance</returns>
        E CreateInvalidEntity();

        /// <summary>
        /// Creates a list of entities
        /// </summary>
        /// <param name="count">the count of the to create entities</param>
        /// <returns>the list holding the created entitiy instance</returns>
        IList<E> CreateValidEntities(int count);

        /// <summary>
        /// Creates an invalid id for the entity type which is never used on the database.
        /// </summary>
        /// <returns>the invalid entity id</returns>
        I CreateInvalidId();

        /// <summary>
        /// Updates the entity fields for an update operation
        /// </summary>
        /// <param name="entity">the entity to get updated fields</param>
        /// <returns>the update entity</returns>
        E UpdateEntity(E entity);

        /// <summary>
        /// Loads the entity by tis id
        /// </summary>
        /// <param name="id">the entity id</param>
        /// <returns></returns>
        E LoadById(I id);

        /// <summary>
        /// Persists the given entity.
        /// </summary>
        /// <param name="entity">the entity to be persisted</param>
        /// <returns>the persisted and loaded entity</returns>
        E Persist(E entity);
    }
}
