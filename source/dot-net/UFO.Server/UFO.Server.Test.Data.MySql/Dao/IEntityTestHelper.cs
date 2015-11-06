using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.MySql.Dao
{
    public interface IEntityTestHelper<I,E> where E : class, IEntity<I>
    {
        void Init();
        E CreateValidEntity(bool setId = false, int idx = 0);
        E CreateInvalidEntity();
        IList<E> CreateValidEntities(int count);
        I getInvalidId();
        E UpdateEntity(E entity);
        E LoadById(I id);
        E Persist(E entity);
    }
}
