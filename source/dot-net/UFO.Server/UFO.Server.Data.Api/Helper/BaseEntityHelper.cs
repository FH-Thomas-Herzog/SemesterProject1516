using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Helper
{
    public abstract class BaseEntityHelper<I, E, C, B, T, P, D, Q> : IEntityHelper<I, E> where E : class, IEntity<I>
                                                                                         where B : DbConnection
                                                                                         where T : DbCommand
                                                                                         where P : DbParameter
                                                                                         where C : BaseDbCommandBuilder<B, T, P, D>
                                                                                         where Q : class, IQueryCreator
    {

        protected Q queryCreator;
        protected readonly EntityMetamodel<I, E> metadata = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
        protected readonly C builder;

        public BaseEntityHelper()
        {
            queryCreator = Activator.CreateInstance(typeof(Q)) as Q;
            builder = PrepareCommandBuilder();
        }

        ~BaseEntityHelper()
        {
            builder.ClearWithConnection();
        }

        public abstract C PrepareCommandBuilder();

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

        public abstract I CreateInvalidId();
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

            I id = (I)builder.ExecuteScalar();
            if (id == null)
            {
                throw new System.Exception("Command could not be executed");
            }
            entity.Id = id;
            builder.Clear();

            return LoadById(entity.Id);
        }
    }
}
