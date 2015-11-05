﻿using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Dao;
using UFO.Server.Test.Data.MySql.Dao;

namespace UFO.Server.Test.Data.MySql.Helper
{
    public class ArtistCategoryEntityTestHelper : BaseEntityTestHelper<long?, ArtistCategory>
    {
        private UserEntityTestHelper userHelper = new UserEntityTestHelper();
        private UserDao userDao = new UserDao();

        private int count = 0;
        private User user;

        public override void Init()
        {
            count++;
            User user = userHelper.CreateValidEntity();
            user.Username = "artistCategoryHelper_" + count;
            user.Email = "artistCategoryHelper_" + count + "@helper.com";
            this.user = userDao.Persist(user);
        }

        public override ArtistCategory CreateInvalidEntity()
        {
            ArtistCategory category = CreateValidEntity();
            category.Description = null;
            category.Name = null;

            return category;
        }

        public override ArtistCategory CreateValidEntity(bool setId = false, int idx = 0)
        {
            Init();
            ArtistCategory category = new ArtistCategory();
            if (setId)
            {
                category.Id = 1;
            }
            category.Name = "GroupName_" + idx;
            category.Description = "Description_" + idx;
            category.CreationUserId = user.Id;
            category.ModificationUserId = user.Id;

            return category;
        }

        public override long? getInvalidId()
        {
            return -1;
        }

        public override ArtistCategory UpdateEntity(ArtistCategory entity)
        {
            if (entity != null)
            {
                entity.Name += "_updated";
                entity.Description += "_updated";
            }

            return entity;
        }
    }
}
