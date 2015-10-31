using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.MySql.Util
{
    public interface IEntityInstanceProvider<I, E> where E : IEntity<I>
    {
        E GetValidEntity(int iterationCount);

        E GetInvalidEntity(int iterationCount);
    }
}
