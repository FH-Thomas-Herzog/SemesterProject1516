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
    public abstract class BaseQueryBuilder<I, E> where E : class, IEntity<I>
    {
        protected string tableName;
        protected string sequenceName;
        protected ISet<string> properties = new HashSet<string>();
        protected ISet<string> selectedProperties = new HashSet<string>();
        protected IDictionary<string, object> whereProperties = new Dictionary<string, object>();
        protected IDictionary<string, ISet<object>> whereInProperties = new Dictionary<string, ISet<object>>();
        private Type type;

        public BaseQueryBuilder()
        {
            Init();
        }

        public BaseQueryBuilder<I, E> Select(params String[] properties)
        {
            foreach (var prop in properties)
            {
                CheckIfValidProperty(prop);
                selectedProperties.Add(prop);
            }

            return this;
        }

        public BaseQueryBuilder<I, E> WhereEq(string property, object value)
        {
            Debug.Assert(value != null, "Null value not allowed");

            CheckIfValidProperty(property);
            whereProperties.Add(property, value);

            return this;
        }

        public BaseQueryBuilder<I, E> WhereIn<T>(string property, params T[] values)
        {
            Debug.Assert(values != null, "Null value not allowed");

            CheckIfValidProperty(property);

            IList<T> listValues = new List<T>();
            foreach (var value in values)
            {
                if (value == null)
                {
                    throw new ArgumentException("Null value not allowed");
                }
                listValues.Add(value);
            }

            whereProperties.Add(property, listValues);

            return this;
        }

        public BaseQueryBuilder<I, E> WhereIn<T>(string property, IList<T> values)
        {
            Debug.Assert(values != null, "Null value not allowed");
            Debug.Assert(values.Count() == 0, "No values provided");

            CheckIfValidProperty(property);

            foreach (var value in values)
            {
                if (value == null)
                {
                    throw new ArgumentException("Null value not allowed");
                }
            }

            whereProperties.Add(property, values);

            return this;
        }

        public BaseQueryBuilder<I, E> Clear()
        {
            properties.Clear();
            selectedProperties.Clear();
            whereInProperties.Clear();
            whereProperties.Clear();

            return this;
        }

        public abstract String Build();

        #region Private
        private void Init()
        {
            type = this.GetType().GetGenericArguments()[1];
            IList<Attribute.Entity> entityAttributes = AttributeUtil.GetAttributes<Attribute.Entity>(type);
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
            PropertyInfo[] properties = type.GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (var prop in properties)
            {
                IList<Column> columns = AttributeUtil.GetAttributes<Column>(prop);
                if (columns.Count != 0)
                {
                    Column col = columns.ElementAt(0);
                    if (!string.IsNullOrWhiteSpace(col.Name))
                    {
                        if (this.properties.Contains(col.Name))
                        {
                            throw new ArgumentException("Column '" + col.Name + "' already defined");
                        }
                        this.properties.Add(col.Name);
                    }
                    else
                    {
                        throw new ArgumentException("Column annotation must provide valid column name");
                    }
                }
            }
        }

        private void CheckIfValidProperty(string property)
        {
            if (!this.properties.Contains(property))
            {
                throw new ArgumentException("Given property '" + property + "' is no property of type '" + nameof(type) + "'");
            }
        }
        #endregion

        #region overwritten
        public override string ToString()
        {
            return nameof(BaseQueryBuilder<I, E>) + "[table=" + tableName + ",sequence=" + sequenceName + "]";
        }
        #endregion
    }

}
