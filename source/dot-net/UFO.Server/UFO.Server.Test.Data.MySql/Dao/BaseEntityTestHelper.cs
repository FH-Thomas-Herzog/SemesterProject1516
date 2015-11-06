using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Attribute;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Db;

namespace UFO.Server.Test.Data.MySql.Dao
{
    public abstract class BaseEntityTestHelper<I, E> : IEntityTestHelper<I, E> where E : class, IEntity<I>
    {
        protected IQueryCreator queryCreator = new MySqlQueryCreator();
        protected readonly EntityMetamodel<I, E> metadata = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
        protected readonly MySqlDbCommandBuilder builder = new MySqlDbCommandBuilder();

        public BaseEntityTestHelper()
        {
            builder.WithConnection((MySqlConnection)DbConnectionFactory.CreateAndOpenConnection())
               .WithTypeResolver(new MySqlDbTypeResolver());
        }

        ~BaseEntityTestHelper()
        {
            builder.ClearWithConnection();
        }

        public abstract void Init();
        public IList<E> CreateValidEntities(int count)
        {
            IList<E> entities = new List<E>();
            for (int i = 1; i <= count; i++)
            {
                entities.Add(CreateValidEntity(false, i));
            }

            return entities;
        }

        public abstract E CreateInvalidEntity();
        public abstract E CreateValidEntity(bool setId = false, int idx = 0);

        public abstract I getInvalidId();
        public abstract E UpdateEntity(E entity);

        public E LoadById(I id)
        {
            E result = null;

            using (IDataReader reader = builder.WithQuery(queryCreator.CreateFullSelectQuery<I, E>())
                                               .SetParameter("?id", id)
                                               .ExecuteReader(CommandBehavior.Default))
            {
                if (reader.Read())
                {
                    result = EntityBuilder.CreateFromReader<I, E>(reader);
                }
            }
            builder.Clear();

            return result;
        }

        public E Persist(E entity)
        {
            IDictionary<string, object> propertyToValueMap = EntityBuilder.ToPropertyValueMap<I, E>(entity, true);
            builder.WithQuery(queryCreator.CreatePersistQuery<I, E>(entity, propertyToValueMap));

            foreach (var entry in propertyToValueMap)
            {
                builder.SetParameter(entry.Key, entry.Value);
            }

            using (MySqlCommand command = builder.Build())
            {
                bool ok = (command.ExecuteNonQuery() == 1);
                if (!ok)
                {
                    throw new Exception("Command could not be executed");
                }
                if (metadata.GetPkType().Equals(PkType.AUTO))
                {
                    entity.Id = (I)(object)command.LastInsertedId;
                }
            }
            builder.Clear();

            return (entity.Id != null) ? LoadById(entity.Id) : null;
        }
    }
}
