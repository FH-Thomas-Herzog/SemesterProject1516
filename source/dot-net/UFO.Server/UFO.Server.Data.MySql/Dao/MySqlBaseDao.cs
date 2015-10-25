using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;
using UFO.Server.Data.MySql.Db;

namespace FO.Server.Data.MySql.Dao
{
    public abstract class MySqlBaseDao<I, E> : IDao<I, E> where E : class, IEntity<I>
    {
        private EntityBuilder<I, E> entityBuilder;
        private EntityMetamodel<I, E> metamodel;
        private MySqlDbCommandBuilder commandBuilder;

        private const string SELECT_BY_ID_TEMPLATE = @"SELECT * FROM {0} WHERE {1} = ?id";
        private const string DELETE_BY_ID_TEMPLATE = @"DELETE FROM {0} WHERE {1} = ?id";
        private const string NEXT_VAL_TEMPLATE = @"SELECT NEXT VALUE for {0}";

        protected MySqlBaseDao()
        {
            entityBuilder = new EntityBuilder<I, E>();
            metamodel = new EntityMetamodel<I, E>();
            commandBuilder = new MySqlDbCommandBuilder();
            commandBuilder.WithTypeResolver(new MySqlDbTypeResolver())
                          .WithConnection(DbConnectionFactory.CreateAndOpenConnection<MySqlConnection>());
        }

        public E Find(I id)
        {
            if (id == null)
            {
                return default(E);
            }

            commandBuilder.Clear()
                          .WithQuery(string.Format(SELECT_BY_ID_TEMPLATE, metamodel.GetFullyQualifiedTableName(), metamodel.GetIdColumn()))
                          .SetParameter("?id", id);

            using (IDataReader reader = commandBuilder.ExecuteReader(CommandBehavior.Default))
            {
                if (reader.Read())
                {
                    return entityBuilder.CreateFromReader(reader);
                }
                return null;
            }
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
            Debug.Assert(id != null, "Cannot delete entity with null id");

            return (commandBuilder.Clear()
                                  .WithQuery(string.Format(SELECT_BY_ID_TEMPLATE, metamodel.GetFullyQualifiedTableName(), metamodel.GetIdColumn()))
                                  .SetParameter("?id", id)
                                  .ExecuteNonQuery() == 1);

        }
        public E Persist(E entity)
        {
            Debug.Assert(entity != null, "Cannot persist null entity");

            switch (metamodel.GetPkType())
            {
                case UFO.Server.Data.Api.Attribute.PkType.MANUAL:
                    if (entity.Id == null)
                    {
                        throw new Exception("PkType is AUTO but entity does not proivde an id value");
                    }
                    break;
                case UFO.Server.Data.Api.Attribute.PkType.SEQUENCE:
                    commandBuilder.Clear()
                                  .WithQuery(string.Format(NEXT_VAL_TEMPLATE, metamodel.GetFullyQualifiedSequenceName()));
                    using (IDataReader reader = commandBuilder.ExecuteReader(CommandBehavior.Default))
                    {
                        if (!reader.Read())
                        {
                            throw new Exception("Could not obtain sequence value");
                        }
                        entity.Id = (I)reader.GetValue(0);
                    }
                    break;
                case UFO.Server.Data.Api.Attribute.PkType.AUTO:
                    // TODO: Do nothing DB will handle
                    break;
                default:
                    throw new Exception("Unknown pk type detected '" + metamodel.GetPkType() + "'");
            }

            StringBuilder sb = new StringBuilder();
            StringBuilder parameters = new StringBuilder(" (");
            StringBuilder values = new StringBuilder(" VALUES(");
            sb.Append("INSERT INTO ")
              .Append(metamodel.GetFullyQualifiedTableName());
            IDictionary<string, object> propertyToValueMap = entityBuilder.ToPropertyValueMap(entity);
            for (int i = 0; i < propertyToValueMap.Count; i++)
            {
                KeyValuePair<string, object> pair = propertyToValueMap.ElementAt(i);
                parameters.Append(metamodel.PropertyToColumn(pair.Key));
                if (i < (propertyToValueMap.Count - 1))
                {
                    parameters.Append(" , ");
                }
                values.Append("?").Append(pair.Key);
                if (i < (propertyToValueMap.Count - 1))
                {
                    values.Append(" , ");
                }
            }
            parameters.Append(")");
            values.Append(")");
            sb.Append(parameters)
              .Append(values);
            commandBuilder.Clear()
                          .WithQuery(sb.ToString());

            foreach (var entry in propertyToValueMap)
            {
                commandBuilder.SetParameter(entry.Key, entry.Value);
            }

            bool ok = (commandBuilder.ExecuteNonQuery() == 1);
            return ById(entity.Id);
        }

        public E Update(E entity)
        {

            return null;
        }
    }
}
