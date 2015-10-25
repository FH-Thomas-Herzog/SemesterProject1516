using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using UFO.Common.Util.Attrbiute;
using UFO.Server.Data.Api.Attribute;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{
    public class EntityBuilder<I, E> where E : class, IEntity<I>
    {
        private EntityMetamodel<I, E> metamodel;

        public EntityBuilder()
        {
            metamodel = new EntityMetamodel<I, E>();
        }
        public E CreateFromReader(IDataReader reader, string alias = " ")
        {
            Debug.Assert(reader != null, "Cannot create entity from null reader");

            E entity = (E)Activator.CreateInstance(metamodel.GetEntityType());
            for (int i = 0; i < reader.FieldCount; i++)
            {
                string name = (alias.Count() > 0) ? reader.GetName(i).Replace(alias, "") : reader.GetName(i);
                string property = metamodel.ColumnToProperty(name);
                if (property != null)
                {
                    metamodel.GetEntityType().GetProperty(property).SetValue(entity, reader.GetValue(i), null);
                }
            }
            return entity;
        }

        public IDictionary<string, object> ToPropertyValueMap(E entity)
        {
            Debug.Assert(entity != null, "Cannot read values from null entity");

            IDictionary<string, object> propertyValueMap = new Dictionary<string, object>();
            foreach (var property in metamodel.GetPropertyNames())
            {
                if (!metamodel.IsReadOnly(property))
                {
                    propertyValueMap[property] = metamodel.GetEntityType().GetProperty(property).GetValue(entity);
                }
            }

            return propertyValueMap;
        }
    }
}
