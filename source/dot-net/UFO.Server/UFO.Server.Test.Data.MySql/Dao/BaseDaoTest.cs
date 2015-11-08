using NUnit.Framework;
using System;
using System.Collections.Generic;
using UFO.Server.Data.Api;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;
using UFO.Server.Data.MySql.Dao;
using UFO.Server.Data.MySql.Helper;
using UFO.Server.Test.Data.MySql.Action;

namespace UFO.Server.Test.Data.MySql.Dao
{
    /// <summary>
    /// This test class tests the basic DAO operations for each contained entity type.
    /// </summary>
    /// <typeparam name="I">the type of the entity id</typeparam>
    /// <typeparam name="E">the type of the entity</typeparam>
    /// <typeparam name="D">the type of the to test dao</typeparam>
    /// <typeparam name="C">th type of the entity backing helper class</typeparam>
    [TestFixture(typeof(long?), typeof(User), typeof(UserDao), typeof(UserEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(ArtistGroup), typeof(ArtistGroupDao), typeof(ArtistGroupEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(ArtistCategory), typeof(ArtistCategoryDao), typeof(ArtistCategoryEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(Artist), typeof(ArtistDao), typeof(ArtistEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(Venue), typeof(VenueDao), typeof(VenueEntityTestHelper))]
    [TestFixture(typeof(long?), typeof(Performance), typeof(PerformanceDao), typeof(PerformanceEntityTestHelper))]
    [CreateDatabase]
    public class BaseDaoTest<I, E, D, C> where E : class, IEntity<I>
                                         where D : class, IDao<I, E>
                                         where C : class, IEntityHelper<I, E>
    {

        // Here we depend on naming convention of factory method names
        // because here we get the dao from the factory via reflections
        protected readonly D dao = typeof(DaoFactory).GetMethod("Create" + typeof(D).Name).Invoke(null, null) as D;
        protected readonly IEntityHelper<I, E> entityHelper = Activator.CreateInstance(typeof(C)) as C;

        [SetUp]
        public void Init()
        {
            entityHelper.Init();
        }

        [TearDown]
        public void Dispose()
        {
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
            I id = entityHelper.CreateInvalidId();

            // -- When --
            dao.ById(id);
        }

        [Test(Description = "dao#ById(valid)")]
        [CleanupDatabase]
        public void ById_Valid()
        {
            // -- Given --
            E entity = entityHelper.Persist(entityHelper.CreateValidEntity());

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
            I id = entityHelper.CreateInvalidId();

            // -- When --
            Assert.IsNull(dao.Find(id));
        }

        [Test(Description = "dao#Find(valid)")]
        [CleanupDatabase]
        public void Find_Valid()
        {
            // -- Given --
            E entity = entityHelper.Persist(entityHelper.CreateValidEntity());

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
            E entity = entityHelper.CreateValidEntity();
            entity.Id = entityHelper.CreateInvalidId();

            // -- When --
            dao.Update(entity);
        }

        // -- Then --
        [Test(Description = "dao#Update(valid)")]
        [CleanupDatabase]
        public void Update_Valid()
        {
            // -- Given --
            E entity = entityHelper.Persist(entityHelper.CreateValidEntity());

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
            E entity = entityHelper.CreateValidEntity(true);

            // -- When --
            dao.Persist(entity);
        }

        // -- Then --
        [Test(Description = "dao#Persist(entity.Property != valid)"), ExpectedException(typeof(PersistenceException))]
        [CleanupDatabase]
        public void Persist_Entity_Invalid()
        {
            // -- Given --
            E entity = entityHelper.CreateInvalidEntity();

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
                entities.Add(entityHelper.CreateValidEntity(false, i));
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
                E loadedEntity = entityHelper.LoadById(persistentEntity.Id);
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
            I id = entityHelper.CreateInvalidId();

            // -- When --
            dao.Delete(id);
        }

        [Test(Description = "dao#Delete(invalid)")]
        [CleanupDatabase]
        public void Delete_Valid()
        {
            // -- Given --
            E entity = entityHelper.Persist(entityHelper.CreateValidEntity());

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
            I id = entityHelper.CreateInvalidId();

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
            I id = entityHelper.Persist(entityHelper.CreateValidEntity()).Id;

            // -- When --
            bool result = dao.EntityExists(id);

            // -- Then --
            Assert.IsTrue(result);
        }
        #endregion
    }
}
