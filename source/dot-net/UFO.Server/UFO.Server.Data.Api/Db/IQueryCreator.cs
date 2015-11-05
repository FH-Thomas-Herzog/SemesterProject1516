using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{
    public interface IQueryCreator 
    {
        string CreateFullSelectQuery<I, E>() where E : class, IEntity<I>;
        string CreateIdSelectQuery<I, E>() where E : class, IEntity<I>;
        string CreatePersistQuery<I, E>(E entity, IDictionary<string, object> propertyToValueMap) where E : class, IEntity<I>;
        string CreateUpdateQuery<I, E>(E entity, IDictionary<string, object> propertyToValueMap) where E : class, IEntity<I>;
        string CreateDeleteQuery<I, E>() where E : class, IEntity<I>;
    }
}
