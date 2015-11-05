using MySql.Data.MySqlClient;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Data;
using UFO.Server.Data.Api.Attribute;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;
using UFO.Server.Data.MySql.Dao;
using UFO.Server.Data.MySql.Db;
using UFO.Server.Test.Data.MySql.Action;
using UFO.Server.Test.Data.MySql.Helper;

namespace UFO.Server.Test.Data.MySql.Dao
{
    [TestFixture(typeof(long?), typeof(User), typeof(UserDao), typeof(UserEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(ArtistGroup), typeof(ArtistGroupDao), typeof(ArtistGroupEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(ArtistCategory), typeof(ArtistCategoryDao), typeof(ArtistCategoryEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(Artist), typeof(ArtistDao), typeof(ArtistEntityTestHelper))]
    [CreateDatabase]
    public class BaseDaoTest<I, E, D, C> where E : class, IEntity<I> where D : class, IDao<I, E> where C : class, IEntityTestHelper<I, E>
    {
        protected IQueryCreator queryCreator = new MySqlQueryCreator();
        protected readonly D dao = (D)Activator.CreateInstance(typeof(D));
        protected readonly EntityMetamodel<I, E> metadata = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
        protected readonly MySqlDbCommandBuilder builder = new MySqlDbCommandBuilder();
        protected readonly IEntityTestHelper<I, E> creator = (C)Activator.CreateInstance(typeof(C));

        [SetUp]
        public void Init()
        {
            creator.Init();
            builder.WithConnection(DbConnectionFactory.CreateAndOpenConnection<MySqlConnection>())
                      .WithTypeResolver(new MySqlDbTypeResolver());
        }

        [TearDown]
        public void Dispose()
        {
            builder.ClearWithConnection();
        }

        #region ById
        // -- Then --
        [Test(Description = "dao#ById(null)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void ById_NullId()
        {
            // -- Given --
            I id = default(I);

            // -- When --
            dao.ById(id);
        }

        // -- Then --
        [Test(Description = "dao#ById(invalid)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void ById_IdNotFound()
        {
            // -- Given --
            I id = creator.getInvalidId();

            // -- When --
            dao.ById(id);
        }

        [Test(Description = "dao#ById(valid)")]
        [CleanupDatabase]
        public void ById_Valid()
        {
            // -- Given --
            E entity = Persist(creator.CreateValidEntity());

            // -- When --
            E loaded = dao.ById(entity.Id);

            // -- Then -- 
            Assert.AreEqual(entity, loaded);
        }
        #endregion

        #region Find
        // -- Then --
        [Test(Description = "dao#Find(null)")]
        [CleanupDatabase]
        public void Find_NullId()
        {
            // -- Given --
            I id = default(I);

            // -- When --
            Assert.IsNull(dao.Find(id));
        }

        // -- Then --
        [Test(Description = "dao#Find(invalid)")]
        [CleanupDatabase]
        public void Find_InvalidId()
        {
            // -- Given --
            I id = creator.getInvalidId();

            // -- When --
            Assert.IsNull(dao.Find(id));
        }

        [Test(Description = "dao#Find(valid)")]
        [CleanupDatabase]
        public void Find_Valid()
        {
            // -- Given --
            E entity = Persist(creator.CreateValidEntity());

            // -- When --
            E loaded = dao.Find(entity.Id);

            // -- Then -- 
            Assert.AreEqual(entity, loaded);
        }
        #endregion

        #region Update
        // -- Then --
        [Test(Description = "dao#Update(null)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Update_NullEntity()
        {
            // -- Given --
            E entity = null;

            // -- When --
            dao.Update(entity);
        }

        // -- Then --
        [Test(Description = "dao#Update(invalidId)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Update_NotFound()
        {
            // -- Given --
            E entity = creator.CreateValidEntity();
            entity.Id = creator.getInvalidId();

            // -- When --
            dao.Update(entity);
        }

        // -- Then --
        [Test(Description = "dao#Update(valid)")]
        [CleanupDatabase]
        public void Update_Valid()
        {
            // -- Given --
            E entity = Persist(creator.CreateValidEntity());

            // -- When --
            E loaded = dao.Update(entity);

            // -- Then --
            Assert.AreEqual(entity, loaded);
        }

        #endregion

        #region Persist
        // -- Then --
        [Test(Description = "dao#Persist(null)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Persist_NullEntity()
        {
            // -- Given --
            E entity = null;

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
                Assert.AreEqual(persistentEntity, loadedEntity);
            }
        }
        #endregion

        #region Delete
        // -- Then --
        [Test(Description = "dao#Delete(null)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Delete_NullEntity()
        {
            // -- Given --
            I id = default(I);

            // -- When --
            dao.Delete(id);
        }

        // -- Then --
        [Test(Description = "dao#Delete(invalid)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Delete_InvalidId()
        {
            // -- Given --
            I id = creator.getInvalidId();

            // -- When --
            dao.Delete(id);
        }

        [Test(Description = "dao#Delete(invalid)")]
        [CleanupDatabase]
        public void Delete_Valid()
        {
            // -- Given --
            E entity = Persist(creator.CreateValidEntity());

            // -- When --
            bool result = dao.Delete(entity.Id);

            // -- Then --
            Assert.IsTrue(result);
        }
        #endregion

        #region EntityExists
        [Test(Description = "dao#EntityExists(null)")]
        [CleanupDatabase]
        public void EntityExists_NullId()
        {
            // -- Given --
            I id = default(I);

            // -- When --
            bool result = dao.EntityExists(id);

            // -- Then --
            Assert.IsFalse(result);
        }

        [Test(Description = "dao#EntityExists(invalid)")]
        [CleanupDatabase]
        public void EntityExists_InvalidId()
        {
            // -- Given --
            I id = creator.getInvalidId();

            // -- When --
            bool result = dao.EntityExists(id);

            // -- Then --
            Assert.IsFalse(result);
        }

        [Test(Description = "dao#EntityExists(valid)")]
        [CleanupDatabase]
        public void EntityExists_Valid()
        {
            // -- Given --
            I id = Persist(creator.CreateValidEntity()).Id;

            // -- When --
            bool result = dao.EntityExists(id);

            // -- Then --
            Assert.IsTrue(result);
        }
        #endregion

        #region Utilities
        protected E LoadById(I id)
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

        protected E Persist(E entity)
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
        #endregion
    }
}
