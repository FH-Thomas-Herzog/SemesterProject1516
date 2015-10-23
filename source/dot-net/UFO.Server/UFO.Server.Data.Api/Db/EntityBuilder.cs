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
    public class EntityBuilder<E, I> where E : IEntity<I>
    {
        public string TableName { get; set; }
        public string SequenceName { get; set; }

        public IDictionary<string, string> ColumnToProperty { get; } = new Dictionary<string, string>();
        public IDictionary<string, string> PropertyToColumn { get; } = new Dictionary<string, string>();

        Type idType;
        Type entityType;

        public EntityBuilder<E, I> Init()
        {
            Clear();
            entityType = this.GetType().GetGenericArguments()[0];
            idType = this.GetType().GetGenericArguments()[1];

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
            TableName = entityAttr.TableName;

            // resolve schema
            if (!string.IsNullOrWhiteSpace(entityAttr.Schema))
            {
                TableName = (entityAttr.Schema + "." + TableName);
            }

            // resolve sequence for id
            if (!string.IsNullOrWhiteSpace(entityAttr.SequenceName))
            {
                SequenceName = entityAttr.SequenceName;
            }

            // resolve entity property names
            PropertyInfo[] properties = entityType.GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (var prop in properties)
            {
                IList<Column> columns = AttributeUtil.GetAttributes<Column>(prop);
                if (columns.Count != 0)
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
            return !this.PropertyToColumn.ContainsKey(property);
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
    }
}
