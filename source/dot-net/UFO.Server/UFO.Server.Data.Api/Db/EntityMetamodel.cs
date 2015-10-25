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
    public class EntityMetamodel<I, E> where E : class, IEntity<I>
    {
        private Type idType;
        private Type entityType;
        private Attribute.Entity entityAttribute;
        private Attribute.Id pkIdAttribute;
        private IDictionary<string, string> propertyToColumnMap = new Dictionary<string, string>();
        private IDictionary<string, string> columnToPropertyMap = new Dictionary<string, string>();
        private IDictionary<string, Attribute.Column> idColumns = new Dictionary<string, Attribute.Column>();
        private IDictionary<string, Attribute.Column> manyToOneFkColumns = new Dictionary<string, Attribute.Column>();
        private IDictionary<string, Attribute.Column> columns = new Dictionary<string, Attribute.Column>();

        public EntityMetamodel()
        {
            Init();
        }

        public string GetTableName()
        {
            return entityAttribute.TableName;
        }

        public string GetSequenceName()
        {
            return entityAttribute.SequenceName;
        }
        public string GetSchema()
        {
            return entityAttribute.Schema;
        }
        public string GetIdColumn()
        {
            return idColumns.First().Key;
        }
        public string GetFullyQualifiedTableName()
        {
            if (GetSchema().Count() > 0)
            {
                return GetSchema() + "." + GetTableName();
            }
            return GetTableName();
        }
        public string GetFullyQualifiedSequenceName()
        {
            if (GetSchema().Count() > 0)
            {
                return GetSchema() + "." + GetSequenceName();
            }
            return GetSequenceName();
        }
        public Type GetEntityType()
        {
            return entityType;
        }
        public Type GetIdType()
        {
            return idType;
        }
        public bool IsPropertyValid(string name)
        {
            return PropertyToColumn(name) != null;
        }
        public bool IsColumnValid(string name)
        {
            return ColumnToProperty(name) != null;
        }
        public string PropertyToColumn(string name)
        {
            string column = null;
            propertyToColumnMap.TryGetValue(name, out column);
            return column;
        }
        public string ColumnToProperty(string name)
        {
            string property = null;
            columnToPropertyMap.TryGetValue(name, out property);
            return property;
        }
        public PkType GetPkType()
        {
            return pkIdAttribute.PkType;
        }
        public ICollection<string> GetPropertyNames()
        {
            return propertyToColumnMap.Keys;
        }
        public bool IsReadOnly(string name)
        {
            if (IsPropertyValid(name))
            {
                return columns[name].ReadOnly;
            }
            throw new System.Exception("Property does not exists in entity");
        }
        private void Init()
        {
            idType = this.GetType().GetGenericArguments()[0];
            entityType = this.GetType().GetGenericArguments()[1];
            IList<Attribute.Entity> attributes = AttributeUtil.GetAttributes<Attribute.Entity>(entityType);
            if (attributes.Count == 0)
            {
                throw new System.Exception("EntityTpye does not provide an Entity attribute");
            }
            entityAttribute = attributes.ElementAt(0);

            IList<PropertyInfo> properties = AttributeUtil.getPropertyInfos<Column>(entityType);
            if (properties.Count() == 0)
            {
                throw new System.Exception("Entity type does not declare any column");
            }
            foreach (var property in properties)
            {
                Column col = AttributeUtil.GetAttributes<Column>(property).ElementAt(0);
                columns[property.Name] = col;
                propertyToColumnMap[property.Name] = col.Name;
                columnToPropertyMap[col.Name] = property.Name;

                IList<Attribute.Id> idAttributes = AttributeUtil.GetAttributes<Attribute.Id>(property);
                if (idAttributes.Count == 1)
                {
                    Attribute.Id idCol = idAttributes.ElementAt(0);
                    if (!idCol.Fk)
                    {
                        if (idColumns.Count == 1)
                        {
                            throw new System.Exception("Entity type does declare multiple id columns");
                        }
                        idColumns[property.Name] = col;
                        pkIdAttribute = idCol;
                    }
                    else if (idCol.manyToOne)
                    {
                        manyToOneFkColumns[property.Name] = col;
                    }
                    else
                    {
                        throw new System.Exception("One to many relations not supported yet");
                    }
                }
            }
            if (idColumns.Count == 0)
            {
                throw new System.Exception("Entity type does not define an id column");
            }
        }
    }
}
