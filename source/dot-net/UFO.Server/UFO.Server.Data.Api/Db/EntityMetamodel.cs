using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UFO.Common.Util.Attrbiute;
using UFO.Server.Data.Api.Attribute;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{
    /// <summary>
    /// This class holds the entity meta-data.
    /// </summary>
    /// <typeparam name="I">the type of the entity id</typeparam>
    /// <typeparam name="E">the type of the entity</typeparam>
    public class EntityMetamodel<I, E> where E : class, IEntity<I>
    {
        private Type idType;
        private Type entityType;
        private Attribute.Entity entityAttribute;
        private Attribute.Id pkIdAttribute;
        private Attribute.Column VersionCol;
        private IDictionary<string, string> propertyToColumnMap = new Dictionary<string, string>();
        private IDictionary<string, string> columnToPropertyMap = new Dictionary<string, string>();
        private IDictionary<string, Attribute.Column> idColumns = new Dictionary<string, Attribute.Column>();
        private IDictionary<string, Attribute.ManyToOne> manyToOneFkColumns = new Dictionary<string, Attribute.ManyToOne>();
        private IDictionary<string, Attribute.Column> columns = new Dictionary<string, Attribute.Column>();

        public EntityMetamodel()
        {
            Init();
        }

        /// <summary>
        /// Gets the physical table name.
        /// </summary>
        /// <returns>the physical table name</returns>
        public string GetPhysicalTableName()
        {
            return entityAttribute.TableName;
        }

        /// <summary>
        /// Gets the entity backed sequence name.
        /// </summary>
        /// <returns>the entity id sequence name, or null if not set</returns>
        public string GetSequenceName()
        {
            return entityAttribute.SequenceName;
        }

        /// <summary>
        /// Gets the physical entity related schema name
        /// </summary>
        /// <returns>the schema name</returns>
        public string GetPhysicalSchemaName()
        {
            return entityAttribute.Schema;
        }

        /// <summary>
        /// Gets the id column name
        /// </summary>
        /// <returns>the id column name</returns>
        public string GetIdColumnName()
        {
            return idColumns.First().Key;
        }

        /// <summary>
        /// Gets the fully qualified physical table name
        /// </summary>
        /// <returns>the fully qualified physical table name</returns>
        public string GetFullyQualifiedPhysicalTableName()
        {
            if (GetPhysicalSchemaName().Count() > 0)
            {
                return GetPhysicalSchemaName() + "." + GetPhysicalTableName();
            }
            return GetPhysicalTableName();
        }

        /// <summary>
        /// Gets the fully qualified physical sequence name.
        /// </summary>
        /// <returns>the full qualified physical sequence name</returns>
        public string GetFullyQualifiedSequenceName()
        {
            if (GetPhysicalSchemaName().Count() > 0)
            {
                return GetPhysicalSchemaName() + "." + GetSequenceName();
            }
            return GetSequenceName();
        }

        /// <summary>
        /// Gets the entity type
        /// </summary>
        /// <returns>the entity type</returns>
        public Type GetEntityType()
        {
            return entityType;
        }

        /// <summary>
        /// Gets the id type
        /// </summary>
        /// <returns>the entity id type</returns>
        public Type GetIdType()
        {
            return idType;
        }

        /// <summary>
        /// Answers the question if the given name points to an valid property.
        /// </summary>
        /// <param name="name">the property name</param>
        /// <returns>true if the name points to an valid property, false otherwise</returns>
        public bool IsPropertyValid(string name)
        {
            return PropertyToColumn(name) != null;
        }

        /// <summary>
        /// Answers the question if the given name points to an valid columnm.
        /// </summary>
        /// <param name="name">the column name</param>
        /// <returns>true if the name points to an valid column, false otherwise</returns>
        public bool IsColumnValid(string name)
        {
            return ColumnToProperty(name) != null;
        }

        /// <summary>
        /// Converts an property name to its related column name.
        /// </summary>
        /// <param name="name">the property name</param>
        /// <returns>the related column name, null if property name is not valid</returns>
        public string PropertyToColumn(string name)
        {
            string column = null;
            propertyToColumnMap.TryGetValue(name, out column);
            return column;
        }

        /// <summary>
        /// Converts an column name to its related property name.
        /// </summary>
        /// <param name="name">the column name</param>
        /// <returns>the related property name, null if column name is not valid</returns>
        public string ColumnToProperty(string name)
        {
            string property = null;
            columnToPropertyMap.TryGetValue(name, out property);
            return property;
        }

        /// <summary>
        /// Gets the type of the primary key.
        /// </summary>
        /// <returns>the primary key type</returns>
        public PkType GetPkType()
        {
            return pkIdAttribute.PkType;
        }

        /// <summary>
        /// Gets a collection of property names
        /// </summary>
        /// <returns>the entity property names which are mapped to an column</returns>
        public ICollection<string> GetPropertyNames()
        {
            return propertyToColumnMap.Keys;
        }

        /// <summary>
        /// Answers the question if the given property if read only
        /// </summary>
        /// <param name="name">the property name</param>
        /// <returns>true if the property is read only, false otherwise</returns>
        public bool IsPropertyReadOnly(string name)
        {
            if (IsPropertyValid(name))
            {
                return columns[name].ReadOnly;
            }
            throw new System.Exception("Property does not exists in entity");
        }

        /// <summary>
        /// Answers the question if this entity is an versioned one.
        /// </summary>
        /// <returns>true if this entity is versioned, false otherwise</returns>
        public bool IsVersionedEntity()
        {
            return this.VersionCol != null;
        }

        /// <summary>
        /// Gets the version column name
        /// </summary>
        /// <returns>the version column name, throws ArgumentException otherwise</returns>
        public string getVersionColumnName()
        {
            if (this.VersionCol != null)
            {
                return VersionCol.Name;
            }
            throw new ArgumentException("This entity does not define a version column");
        }
        /// <summary>
        /// Gets the version property
        /// </summary>
        /// <returns>the version property, throws ArgumentException otherwise</returns>
        public string getVersionProperty()
        {
            return ColumnToProperty(getVersionColumnName());
        }

        /// <summary>
        /// Initializes this instance by extracting all needed information of the given entity type.
        /// </summary>
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
                IList<Attribute.ManyToOne> manyToOneAttributes = AttributeUtil.GetAttributes<Attribute.ManyToOne>(property);

                if (idAttributes.Count == 1)
                {
                    Attribute.Id idCol = idAttributes.ElementAt(0);
                    if (idColumns.Count == 1)
                    {
                        throw new System.Exception("Entity type does declare multiple id columns");
                    }
                    idColumns[property.Name] = col;
                    pkIdAttribute = idCol;
                    if (col.Version)
                    {
                        if (VersionCol != null)
                        {
                            throw new ArgumentException("Multiple entity column propery with version=true found. first: " + ColumnToProperty(VersionCol.Name) + ", second: " + ColumnToProperty(col.Name));
                        }
                        this.VersionCol = col;
                    }
                }
                else if (manyToOneAttributes.Count == 1)
                {
                    Attribute.ManyToOne manyToOneCol = manyToOneAttributes.ElementAt(0);
                    if (!IsPropertyValid(manyToOneCol.FkProperty))
                    {
                        throw new System.Exception("ManyToOne mapped property is invalid. property: '" + manyToOneCol.FkProperty + "'");
                    }
                    if (manyToOneFkColumns.ContainsKey(manyToOneCol.FkProperty))
                    {
                        throw new System.Exception("Entity does map a manyToOne property multiple times. property: " + property.Name + "'");
                    }
                    manyToOneFkColumns[manyToOneCol.FkProperty] = manyToOneCol;
                }
            }
            if (idColumns.Count == 0)
            {
                throw new System.Exception("Entity type does not define an id column");
            }
        }
    }
}
