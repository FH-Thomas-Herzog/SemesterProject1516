using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.MySql.Dao
{
    public interface IEntityCreator<I,E> where E : class, IEntity<I>
    {
        E CreateValidEntity(bool setId = false, int idx = 0);
        E CreateInvalidEntity();
        IList<E> CreateValidEntities(int count);
    }
}
