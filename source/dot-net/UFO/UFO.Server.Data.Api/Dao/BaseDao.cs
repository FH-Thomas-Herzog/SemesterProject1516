using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using UFO.Server.Data.Api.Attribute;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;

namespace UFO.Server.Data.Api
{

    /// <summary>
    /// This class is the base for all dao implementation and provides a generic implementation of the base dao operations.
    /// The inherit dao only needs to provide additional functionalities.
    /// </summary>
    /// <typeparam name="I">the type of the entity id</typeparam>
    /// <typeparam name="E">the type of the entity</typeparam>
    /// <typeparam name="C">the type of the used command builder</typeparam>
    /// <typeparam name="B">the type of the used connection</typeparam>
    /// <typeparam name="T">the type of the used db command</typeparam>
    /// <typeparam name="P">the type of the db parameter</typeparam>
    /// <typeparam name="D">the type of the db type enumeration</typeparam>
    /// <typeparam name="Q">the type of the query creator</typeparam>
    public abstract class BaseDao<I, E, C, B, T, P, D, Q> : IDao<I, E> where E : class, IEntity<I>
                                                                    where B : DbConnection
                                                                    where T : DbCommand
                                                                    where P : DbParameter
                                                                    where C : BaseDbCommandBuilder<B, T, P, D>
                                                                    where Q : class, IQueryCreator
    {

        protected Q queryCreator;
        protected EntityMetamodel<I, E> metamodel;
        protected C commandBuilder;

        /// <summary>
        /// Constructs an instance of the curren type by preparing all instance members needed.
        /// </summary>
        public BaseDao(B connection = default(B))
        {
            try
            {
                queryCreator = Activator.CreateInstance(typeof(Q)) as Q;
                metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
                this.commandBuilder = prepareCommandBuilder(connection);
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Could not construct '" + this.GetType().Name + "'", e);
            }
        }

        /// <summary>
        /// Prepares the command builcer for this dao.
        /// Inherit type needs to set connection on builder.
        /// </summary>
        /// <returns>the prepared command builder instance</returns>
        protected abstract C prepareCommandBuilder(B connection = default(B));

        public E Find(I id)
        {
            E result = null;
            if (id == null)
            {
                return result;
            }

            commandBuilder.Clear()
                          .WithQuery(queryCreator.CreateFullSelectQuery<I, E>())
                          .SetParameter("?id", id);

            using (IDataReader reader = commandBuilder.ExecuteReader(CommandBehavior.Default))
            {
                if (reader.Read())
                {
                    result = EntityBuilder.CreateFromReader<I, E>(reader);
                }
            }

            commandBuilder.Clear();

            return result;
        }

        public E ById(I id)
        {
            E entity = Find(id);

            if (entity == null)
            {
                throw new EntityNotFoundException("Entity '" + metamodel.GetEntityType().Name + "' with id: '" + ((id != null) ? id.ToString() : "null") + "' not found");
            }

            return entity;
        }
        public bool Delete(I id)
        {
            bool result = false;
            if (!EntityExists(id))
            {
                throw new EntityNotFoundException("Entity with id: '" + id.ToString() + "' not found");
            }

            try
            {
                result = (commandBuilder.Clear()
                                  .WithQuery(queryCreator.CreateDeleteQuery<I, E>())
                                  .SetParameter("?id", id)
                                  .ExecuteNonQuery() == 1);
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Could not construct '" + this.GetType().Name + "'", e);
            }
            finally
            {
                commandBuilder.Clear();
            }

            return result;
        }

        public E Persist(E entity)
        {

            if (entity == null)
            {
                throw new ArgumentException("Entity must not be null");
            }

            I id = entity.Id;

            switch (metamodel.GetPkType())
            {
                case UFO.Server.Data.Api.Attribute.PkType.MANUAL:
                    if (id == null)
                    {
                        throw new ArgumentException("PkType is AUTO but entity does not proivde an id value");
                    }
                    break;
                case UFO.Server.Data.Api.Attribute.PkType.AUTO:
                    if (id != null)
                    {
                        throw new ArgumentException("Entity id is provided automatically and therefore must not be provided");
                    }
                    break;
                default:
                    throw new ArgumentException("Unknown pk type detected '" + metamodel.GetPkType() + "'");
            }

            try
            {
                IDictionary<string, object> propertyToValueMap = EntityBuilder.CreateFromEntity<I, E>(entity, true);
                commandBuilder.Clear()
                              .WithQuery(queryCreator.CreatePersistQuery<I, E>(entity, propertyToValueMap));

                foreach (var entry in propertyToValueMap)
                {
                    commandBuilder.SetParameter(entry.Key, entry.Value);
                }

                // Get last insert id for auto pk
                if (metamodel.GetPkType().Equals(PkType.AUTO))
                {
                    id = (I)commandBuilder.ExecuteScalar();

                    if (id == null)
                    {
                        throw new System.Exception("Command.ExecuteScalar did not return the last insert id which it should");
                    }
                }

                entity.Id = id;
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Persist failed", e);
            }
            finally
            {
                // Clears command and we don't hold reference
                commandBuilder.Clear();
            }

            return ById(entity.Id);
        }

        public E Update(E entity)
        {
            E result = null;
            if ((entity == null) || (entity.Id == null))
            {
                throw new ArgumentException("Cannot update null entity or entity with null id");
            }

            E entityDB = Find(entity.Id);
            if (entityDB == null)
            {
                throw new EntityNotFoundException("Entity with id: '" + entity.Id.ToString() + "' not found");
            }
            if ((entityDB is IVersionedEntity) && (!(entityDB as IVersionedEntity).Version.Equals((entity as IVersionedEntity).Version)))
            {
                throw new ConcurrentUpdateException("Entity Version is different from daabase state");
            }

            try
            {
                IDictionary<string, object> propertyToValueMap = EntityBuilder.CreateFromEntity<I, E>(entity, true);
                commandBuilder.WithQuery(queryCreator.CreateUpdateQuery<I, E>(entity, propertyToValueMap))
                              .SetParameter("?id", entity.Id);
                foreach (var entry in propertyToValueMap)
                {
                    commandBuilder.SetParameter(entry.Key, entry.Value);
                }
                if (commandBuilder.ExecuteNonQuery() == 1)
                {
                    result = ById(entity.Id);
                }
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Persist failed", e);
            }
            finally
            {
                commandBuilder.Clear();
            }

            return result;
        }

        public bool EntityExists(I id)
        {
            bool exists = false;
            if (id != null)
            {
                using (IDataReader reader = commandBuilder.WithQuery(queryCreator.CreateIdSelectQuery<I, E>())
                                                          .SetParameter("?id", id)
                                                          .ExecuteReader(CommandBehavior.Default))
                {
                    exists = reader.Read();
                }
                commandBuilder.Clear();
            }

            return exists;
        }

        public void Dispose()
        {
            commandBuilder?.ClearWithConnection();
        }
    }
}
