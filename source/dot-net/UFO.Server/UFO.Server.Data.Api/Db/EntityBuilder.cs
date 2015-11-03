﻿using System;
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

    /// <summary>
    /// This class is a helper class for creating and reading entity instances.
    /// It allos to extract and fill entity properties.
    /// </summary>
    /// <typeparam name="I">the type of the entity id</typeparam>
    /// <typeparam name="E">the type of the entity</typeparam>
    public class EntityBuilder<I, E> where E : class, IEntity<I>
    {
        private EntityMetamodel<I, E> metamodel;

        public EntityBuilder()
        {
            metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
        }


        /// <summary>
        /// Creates an entity instance and fills it with the data of the IReader instance.
        /// </summary>
        /// <param name="reader">the reader to get property values from</param>
        /// <param name="alias">the alias used for the selected property</param>
        /// <returns>the created and filled entity</returns>
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
                    var propertyType = metamodel.GetEntityType().GetProperty(property).PropertyType;
                    object converted = null;
                    if ((!reader.IsDBNull(i)) && (Nullable.GetUnderlyingType(propertyType) != null))
                    {
                        converted = System.Convert.ChangeType(reader.GetValue(i), Nullable.GetUnderlyingType(propertyType));
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
        public IDictionary<string, object> ToPropertyValueMap(E entity, bool includeNull = true)
        {
            Debug.Assert(entity != null, "Cannot read values from null entity");

            IDictionary<string, object> propertyValueMap = new Dictionary<string, object>();
            foreach (var property in metamodel.GetPropertyNames())
            {
                if ((!metamodel.IsPropertyReadOnly(property) && (!metamodel.GetIdColumnName().Equals(property))))
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
