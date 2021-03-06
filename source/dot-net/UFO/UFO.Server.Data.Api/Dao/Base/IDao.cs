﻿using System;
using System.Collections.Generic;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Dao.Base
{

    /// <summary>
    /// This interface specifies the minimum operations 
    /// which have to be supported by any DAO implementation.
    /// </summary>
    /// <typeparam name="I">The type of the backed entity id</typeparam>
    /// <typeparam name="E">The type of the backed entity</typeparam>
    public interface IDao<I, E> : IDisposable where E : IEntity<I>
    {

        /// <summary>
        /// Persists the given entity.
        /// </summary>
        /// <param name="entity">the entity to be persisted</param>
        /// <returns>the entity representing the current state on the database</returns>
        E Persist(E entity);


        /// <summary>
        /// Updates the given entity.
        /// </summary>
        /// <param name="entity">The entity to be updated</param>
        /// <returns>the entity representing the current state on the database</returns>
        /// <exception cref="EntityNotFoundException">If the entity could not be found</exception>
        E Update(E entity);


        /// <summary>
        /// Deletes the entity with the given id.
        /// </summary>
        /// <param name="id">the entity id</param>
        /// <returns>true if the entity was deleted, false otherwise</returns>
        /// <exception cref="EntityNotFoundException">If the entity could not be found</exception>
        bool Delete(I id);

        /// <summary>
        /// Gets the entity by its id.
        /// </summary>
        /// <param name="id">the entity id</param>
        /// <returns>the found entity</returns>
        /// <exception cref="EntityNotFoundException">If the entity could not be found</exception>
        E ById(I id);

        /// <summary>
        /// Gets the entity by its id.
        /// </summary>
        /// <param name="id">the entity id</param>
        /// <returns>the found entity or null if the entity does not exist</returns>
        E Find(I id);

        /// <summary>
        /// Finds all entities.
        /// </summary>
        /// <returns>the list of found entities</returns>
        IList<E> FindAll();

        /// <summary>
        /// Answers the question if the entity with the given id exists on the database.
        /// </summary>
        /// <param name="id">the entity id</param>
        /// <returns>true if entity exists, false otherwise</returns>
        bool EntityExists(I id);
    }
}
