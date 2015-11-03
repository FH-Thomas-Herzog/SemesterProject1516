using MySql.Data.MySqlClient;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;
using UFO.Server.Data.MySql.Dao;
using UFO.Server.Data.MySql.Db;
using UFO.Server.Test.Data.MySql.Action;

namespace UFO.Server.Test.Data.MySql.Dao
{
    [TestFixture(typeof(long?), typeof(User), typeof(UserDao), typeof(UserEntityCreator)), CreateDatabase]
    public class BaseDaoTest<I, E, D, C> where E : class, IEntity<I> where D : class, IDao<I, E> where C : class, IEntityCreator<I, E>
    {
        protected readonly D dao = (D)Activator.CreateInstance(typeof(D));
        protected readonly EntityMetamodel<I, E> metadata = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
        protected readonly EntityBuilder<I, E> entityBuidler = new EntityBuilder<I, E>();
        protected readonly MySqlDbCommandBuilder builder = new MySqlDbCommandBuilder();
        protected readonly IEntityCreator<I, E> creator = (C)Activator.CreateInstance(typeof(C));

        #region Persist
        // -- Then --
        [Test(Description = "dao#Persist(null)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Persist_NullEntity()
        {
            // -- Given --
            E entity = default(E);

            // -- When --
            dao.Persist(entity);
        }

        // -- Then --
        [Test(Description = "dao#Persist(entity.id != null)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Persist_EntityIdInvalid()
        {
            // -- Given --
            E entity = creator.CreateValidEntity(true);

            // -- When --
            dao.Persist(entity);
        }

        // -- Then --
        [Test(Description = "dao#Persist(entity.Property != valid)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Persist_Entity_Invalid()
        {
            // -- Given --
            E entity = creator.CreateInvalidEntity();

            // -- When --
            dao.Persist(entity);
        }

        [Test(Description = "dao#Persist(entity) 100 times")]
        [CleanupDatabase]
        public void Persist_Valid()
        {
            // -- Given --
            IList<E> persistet = new List<E>();
            IList<E> entities = new List<E>();
            for (int i = 0; i < 100; i++)
            {
                entities.Add(creator.CreateValidEntity(false, i));
            }

            // -- When --
            foreach (var entity in entities)
            {
                persistet.Add(dao.Persist(entity));
            }

            // -- Then --
            for (int i = 0; i < entities.Count; i++)
            {
                E entity = entities[i];
                E persistentEntity = persistet[i];
                E loadedEntity = LoadById(persistentEntity.Id);
                persistentEntity.Equals(loadedEntity);
            }
        }
        #endregion

        protected E LoadById(I id)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT * FROM ").Append(metadata.GetFullyQualifiedPhysicalTableName())
              .Append(" WHERE ").Append(metadata.GetIdColumnName()).Append(" = @id");
            IDataReader reader = builder.WithConnection(DbConnectionFactory.CreateAndOpenConnection<MySqlConnection>())
                   .WithTypeResolver(new MySqlDbTypeResolver())
                   .WithQuery(sb.ToString())
                   .SetParameter("@id", id)
                   .ExecuteReader(CommandBehavior.Default);
            reader.Read();
            return entityBuidler.CreateFromReader(reader);
        }
    }
}
