﻿using System.Collections.Generic;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{
    public interface IQueryCreator
    {
        /// <summary>
        /// Creates a full select statement for the given type
        /// </summary>
        /// <typeparam name="I">the type of the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <returns>the created query</returns>
        string CreateFullSelectQuery<I, E>() where E : class, IEntity<I>;

        /// <summary>
        /// Creates a id select only statement for the given type
        /// </summary>
        /// <typeparam name="I">the type of the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <returns>the created query</returns>
        string CreateIdSelectQuery<I, E>() where E : class, IEntity<I>;

        /// <summary>
        /// eates a id versioned select query for the given type
        /// </summary>
        /// <typeparam name="I">the type fo the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <returns>the created query</returns>
        string CreateIdVersionedSelectQuery<I, E>() where E : class, IEntity<I>;

        /// <summary>
        /// Creates an persist query for the given entity type
        /// </summary>
        /// <typeparam name="I">the type of the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <param name="entity"the entity instance></param>
        /// <param name="propertyToValueMap">the map of properties inluded in the insert statement</param>
        /// <returns>the created query</returns>
        string CreatePersistQuery<I, E>(E entity, IDictionary<string, object> propertyToValueMap) where E : class, IEntity<I>;

        /// <summary>
        /// Creates an update query for the given entity type
        /// </summary>
        /// <typeparam name="I">the type of the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <param name="entity"the entity instance></param>
        /// <param name="propertyToValueMap">the map of properties inluded in the insert statement</param>
        /// <returns>the created query</returns>
        string CreateUpdateQuery<I, E>(E entity, IDictionary<string, object> propertyToValueMap) where E : class, IEntity<I>;

        /// <summary>
        /// Creates a delete statement for the given entity type.
        /// </summary>
        /// <typeparam name="I">the type of the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <returns>the created query</returns>
        string CreateDeleteQuery<I, E>() where E : class, IEntity<I>;

        /// <summary>
        /// Creates the get all query.
        /// </summary>
        /// <typeparam name="I">the type of the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <returns></returns>
        string CreateGetAllQuery<I, E>() where E : class, IEntity<I>;
    }
}
