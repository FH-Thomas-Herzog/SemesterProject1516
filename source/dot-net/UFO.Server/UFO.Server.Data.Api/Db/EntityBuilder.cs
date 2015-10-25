using System;
using System.Collections.Generic;
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
    public class EntityBuilder<I, E> where E : IEntity<I>
    {
        public string tableName;
        public string sequenceName;

        public IDictionary<string, string> ColumnToProperty { get; } = new Dictionary<string, string>();
        public IDictionary<string, string> PropertyToColumn { get; } = new Dictionary<string, string>();

        private Type idType;
        private Type entityType;

        public EntityBuilder<I, E> Init()
        {
            Clear();
            idType = this.GetType().GetGenericArguments()[0];
            entityType = this.GetType().GetGenericArguments()[1];

            IList<Attribute.Entity> entityAttributes = AttributeUtil.GetAttributes<Attribute.Entity>(entityType);
            if (entityAttributes.Count == 0)
            {
                throw new ArgumentException("Given type does not define an Entity attribute");
            }
            Attribute.Entity entityAttr = entityAttributes.ElementAt(0);
            // Resolve table name
            if (string.IsNullOrWhiteSpace(entityAttr.TableName))
            {
                throw new ArgumentException("Entity attribute does not provide an table name");
            }
            tableName = entityAttr.TableName;

            // resolve schema
            if (!string.IsNullOrWhiteSpace(entityAttr.Schema))
            {
                tableName = (entityAttr.Schema + "." + tableName);
            }

            // resolve sequence for id
            if (!string.IsNullOrWhiteSpace(entityAttr.SequenceName))
            {
                sequenceName = entityAttr.SequenceName;
            }

            // resolve entity property names
            PropertyInfo[] properties = entityType.GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (var prop in properties)
            {
                IList<Column> columns = AttributeUtil.GetAttributes<Column>(prop);
                if (columns.Count > 0)
                {
                    Column col = columns.ElementAt(0);
                    if (!string.IsNullOrWhiteSpace(col.Name))
                    {
                        if (this.ColumnToProperty.ContainsKey(col.Name))
                        {
                            throw new ArgumentException("Column '" + col.Name + "' already defined");
                        }
                        this.ColumnToProperty[col.Name] = prop.Name;
                        this.PropertyToColumn[prop.Name] = col.Name;
                    }
                    else
                    {
                        throw new ArgumentException("Column annotation must provide valid column name");
                    }
                }
            }
            return this;
        }

        public bool IsPropertyValid(string property)
        {
            return PropertyToColumn.ContainsKey(property);
        }

        public string ConvertPropertyToColumn(string property)
        {
            Debug.Assert(property != null, "Cannot get column name for null property");
            string value = null;
            PropertyToColumn.TryGetValue(property, out value);
            return value;
        }

        public string ConvertColumnToProperty(string column)
        {
            Debug.Assert(column != null, "Cannot get property name for null column");
            string value = null;
            ColumnToProperty.TryGetValue(column, out value);
            return value;
        }

        public void Clear()
        {
            PropertyToColumn.Clear();
            ColumnToProperty.Clear();
        }

        public E Create(IDictionary<string, object> properties)
        {
            Debug.Assert(properties != null, "Properties must not be null for creating an entity");

            E entity = (E)Activator.CreateInstance(entityType);
            foreach (var entry in properties)
            {
                entityType.GetProperty(entry.Key).SetValue(entity, entry.Value);
            }

            return entity;
        }

        public IDictionary<string, object> Extract(E entity)
        {
            Debug.Assert(entity != null, "Cannot extract properties of null entity");

            IDictionary<string, object> properties = new Dictionary<string, object>();
            foreach (var entry in PropertyToColumn)
            {
                properties[entry.Value] = entityType.GetProperty(entry.Key).GetValue(entity, null);
            }

            return properties;
        }

        #region Private

        #endregion
    }
}
