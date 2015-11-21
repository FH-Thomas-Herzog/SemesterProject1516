using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{

    /// <summary>
    /// This class is a helper class for creating and reading entity instances.
    /// It allos to extract and fill entity properties.
    /// </summary>
    /// <typeparam name="I">the type of the entity id</typeparam>
    /// <typeparam name="E">the type of the entity</typeparam>
    public class EntityBuilder
    {
        /// <summary>
        /// Creates an entity instance and fills it with the data of the IReader instance.
        /// </summary>
        /// <param name="reader">the reader to get property values from</param>
        /// <param name="alias">the alias used for the selected property</param>
        /// <returns>the created and filled entity</returns>
        public static E CreateFromReader<I, E>(IDataReader reader, string alias = " ") where E : class, IEntity<I>
        {
            Debug.Assert(reader != null, "Cannot create entity from null reader");

            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            E entity = (E)Activator.CreateInstance(metamodel.GetEntityType());
            for (int i = 0; i < reader.FieldCount; i++)
            {
                string name = (alias.Count() > 0) ? reader.GetName(i).Replace(alias, "") : reader.GetName(i);
                string property = metamodel.ColumnToProperty(name);
                if (property != null)
                {
                    var propertyType = metamodel.GetEntityType().GetProperty(property).PropertyType;
                    object converted = null;
                    if ((!reader.IsDBNull(i)) && (Nullable.GetUnderlyingType(propertyType) != null))
                    {
                        converted = System.Convert.ChangeType(reader.GetValue(i), Nullable.GetUnderlyingType(propertyType));
                    }
                    else if (!reader.IsDBNull(i))
                    {
                        converted = reader.GetValue(i);
                    }
                    metamodel.GetEntityType().GetProperty(property).SetValue(entity, converted, null);
                }
            }
            return entity;
        }


        /// <summary>
        /// Extracts the entity properties and maps them to their set values
        /// </summary>
        /// <param name="entity">the entity to extract properties from</param>
        /// <param name="includeNull">true if null values shall be included. default = true</param>
        /// <returns>the dictonary which maps the property name to the set value</returns>
        public static IDictionary<string, object> CreateFromEntity<I, E>(E entity, bool includeNull = true) where E : class, IEntity<I>
        {
            Debug.Assert(entity != null, "Cannot read values from null entity");

            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            IDictionary<string, object> propertyValueMap = new Dictionary<string, object>();
            foreach (var property in metamodel.GetPropertyNames())
            {
                if ((!metamodel.IsPropertyReadOnly(property)) &&
                    ((!metamodel.IsVersionedEntity()) || (!metamodel.getVersionProperty().Equals(property))))
                {
                    object value = metamodel.GetEntityType().GetProperty(property).GetValue(entity);

                    if ((includeNull) || ((!includeNull) && (value != null)))
                    {
                        propertyValueMap[property] = value;
                    }

                }
            }

            return propertyValueMap;
        }
    }
}
