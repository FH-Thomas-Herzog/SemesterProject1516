using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;

namespace UFO.Server.Data.Api.Dao
{
    public abstract class BaseDao<I, E> : IDao<I, E> where E : IEntity<I>
    {
        private Type idType;
        private Type entityType;

        protected BaseDao()
        {
            entityType = GetType();
            idType = entityType.GetGenericArguments()[0];
        }

        public E Find(I id)
        {
            // TODO: Use type information for generating byId query.
            return default(E);
        }

        public E ById(I id)
        {
            E entity = default(E);
            entity = Find(id);

            if (entity == null)
            {
                throw new EntityNotFoundException("Entity '" + entityType.Name + "' with id: '" + ((id != null) ? id.ToString() : "null") + "' not found");
            }

            return entity;
        }
        public abstract void Delete(I id);
        public abstract E Persist(E entity);
        public abstract E Update(E entity);
    }
}
