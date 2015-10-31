using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{

    /// <summary>
    /// This singleton implementation is used for caching and providing the entity meta models.
    /// Therefore that hese models are read only its good to cache them.
    /// </summary>
    public class EntityMetamodelFactory
    {
        private IDictionary<Type, object> metaCache = new ConcurrentDictionary<Type, object>();

        private static EntityMetamodelFactory instance;

        private EntityMetamodelFactory()
        {

        }

        /// <summary>
        /// Creates the singleton instance if necessary
        /// </summary>
        /// <returns>the singleton instance</returns>
        public static EntityMetamodelFactory GetInstance()
        {
            if (EntityMetamodelFactory.instance == null)
            {
                EntityMetamodelFactory.instance = new EntityMetamodelFactory();
            }
            return EntityMetamodelFactory.instance;
        }


        /// <summary>
        /// Gets the meta model which gets created for the given generic arguments.
        /// </summary>
        /// <typeparam name="I">the type of the entity id</typeparam>
        /// <typeparam name="E">the type of the entity</typeparam>
        /// <returns>the related entity metamodel instance</returns>
        public EntityMetamodel<I, E> GetMetaModel<I, E>() where E : class, IEntity<I>
        {
            object metamodel = null;
            metaCache.TryGetValue(typeof(E), out metamodel);
            if (metamodel == null)
            {
                metamodel = new EntityMetamodel<I, E>();
                metaCache[typeof(E)] = metamodel;
            }
            return (EntityMetamodel<I, E>)metamodel;
        }
    }
}
