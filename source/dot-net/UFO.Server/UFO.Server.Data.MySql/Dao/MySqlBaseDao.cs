using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Attribute;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;
using UFO.Server.Data.MySql.Db;

namespace FO.Server.Data.MySql.Dao
{
    public abstract class MySqlBaseDao<I, E> : IDao<I, E> where E : class, IEntity<I>
    {
        protected IQueryCreator queryCreator = new MySqlQueryCreator();
        private EntityMetamodel<I, E> metamodel;
        private MySqlDbCommandBuilder commandBuilder;

        private const string SELECT_BY_ID_TEMPLATE = @"SELECT * FROM {0} WHERE {1} = ?id";
        private const string DELETE_BY_ID_TEMPLATE = @"DELETE FROM {0} WHERE {1} = ?id";
        private const string NEXT_VAL_TEMPLATE = @"SELECT NEXT VALUE for {0}";

        protected MySqlBaseDao()
        {
            metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            commandBuilder = new MySqlDbCommandBuilder();
            commandBuilder.WithTypeResolver(new MySqlDbTypeResolver())
                          .WithConnection(DbConnectionFactory.CreateAndOpenConnection<MySqlConnection>());
        }

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
                throw new PersistenceException("Entity '" + metamodel.GetEntityType().Name + "' with id: '" + ((id != null) ? id.ToString() : "null") + "' not found");
            }

            return entity;
        }
        public bool Delete(I id)
        {
            bool result = false;
            try
            {
                if (!EntityExists(id))
                {
                    throw new PersistenceException("Entity with id: '" + id.ToString() + "' not found");
                }

                result = (commandBuilder.Clear()
                                  .WithQuery(queryCreator.CreateDeleteQuery<I, E>())
                                  .SetParameter("?id", id)
                                  .ExecuteNonQuery() == 1);
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Could not delete entity", e);
            }
            finally
            {
                commandBuilder.Clear();
            }

            return result;
        }

        public E Persist(E entity)
        {
            try
            {
                if (entity == null)
                {
                    new ArgumentException("Entity must not be null");
                }

                switch (metamodel.GetPkType())
                {
                    case UFO.Server.Data.Api.Attribute.PkType.MANUAL:
                        if (entity.Id == null)
                        {
                            throw new ArgumentException("PkType is AUTO but entity does not proivde an id value");
                        }
                        break;
                    case UFO.Server.Data.Api.Attribute.PkType.SEQUENCE:
                        if (entity.Id == null)
                        {
                            throw new ArgumentException("Entity id is provided via sequence an therefore must not be provided");
                        }
                        commandBuilder.Clear()
                                      .WithQuery(string.Format(NEXT_VAL_TEMPLATE, metamodel.GetFullyQualifiedSequenceName()));
                        using (IDataReader reader = commandBuilder.ExecuteReader(CommandBehavior.Default))
                        {
                            if (!reader.Read())
                            {
                                throw new Exception("Could not obtain sequence value for entity#Id");
                            }
                            entity.Id = (I)reader.GetValue(0);
                        }
                        break;
                    case UFO.Server.Data.Api.Attribute.PkType.AUTO:
                        if (entity.Id != null)
                        {
                            throw new ArgumentException("Entity id is provided automatically and therefore must not be provided");
                        }
                        break;
                    default:
                        throw new ArgumentException("Unknown pk type detected '" + metamodel.GetPkType() + "'");
                }

                IDictionary<string, object> propertyToValueMap = EntityBuilder.ToPropertyValueMap<I, E>(entity, true);
                commandBuilder.Clear()
                              .WithQuery(queryCreator.CreatePersistQuery<I, E>(entity, propertyToValueMap));

                foreach (var entry in propertyToValueMap)
                {
                    commandBuilder.SetParameter(entry.Key, entry.Value);
                }

                MySqlCommand command = commandBuilder.Build();
                bool ok = (commandBuilder.ExecuteNonQuery() == 1);
                if (!ok)
                {
                    throw new Exception("Command could not be executed");
                }
                // GEt last insert id for auto pk
                if (metamodel.GetPkType().Equals(PkType.AUTO))
                {
                    entity.Id = (I)(object)command.LastInsertedId;
                }
            }
            catch (Exception e)
            {
                throw new PersistenceException(this.GetType().Name + "#Persist(entity) failed", e);
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
            try
            {
                if ((entity == null) || (entity.Id == null))
                {
                    throw new ArgumentException("Cannot update null entity or entity with null id");
                }

                if (!EntityExists(entity.Id))
                {
                    throw new PersistenceException("Entity with id: '" + entity.Id.ToString() + "' not found");
                }

                IDictionary<string, object> propertyToValueMap = EntityBuilder.ToPropertyValueMap<I, E>(entity, true);
                commandBuilder.WithQuery(queryCreator.CreateUpdateQuery<I, E>(entity, propertyToValueMap))
                              .SetParameter("?id", entity.Id);
                foreach (var entry in propertyToValueMap)
                {
                    commandBuilder.SetParameter(entry.Key, entry.Value);
                }
                if(commandBuilder.ExecuteNonQuery() == 1)
                {
                    result = ById(entity.Id);
                }
            }
            catch (System.Exception e)
            {
                throw new PersistenceException("Could not update entity", e);
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
    }
}
