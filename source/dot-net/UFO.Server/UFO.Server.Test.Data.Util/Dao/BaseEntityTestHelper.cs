using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.MySql.Dao
{
    public abstract class BaseEntityTestHelper<I, E> : IEntityTestHelper<I, E> where E : class, IEntity<I>
    {
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
    }
}
