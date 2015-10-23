using System;
using System.Collections.Generic;
using System.Data.Common;
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
    public abstract class BaseQueryBuilder<I, E, C> where E : class, IEntity<I> where C : DbCommand
    {
        protected ISet<string> selectedProperties = new HashSet<string>();
        protected IDictionary<string, object> whereProperties = new Dictionary<string, object>();
        protected IDictionary<string, ISet<object>> whereInProperties = new Dictionary<string, ISet<object>>();

        private Type type;
        protected EntityBuilder<E, I> entityBuilder;

        public BaseQueryBuilder()
        {
            Init();
        }

        public void Init()
        {
            Clear();
            entityBuilder = new EntityBuilder<E, I>().Init();
        }

        public BaseQueryBuilder<I, E, C> SelectAll()
        {
            foreach (var key in entityBuilder.PropertyToColumn.Keys)
            {
                selectedProperties.Add(key);
            }

            return this;
        }
        public BaseQueryBuilder<I, E, C> Select(params String[] properties)
        {
            foreach (var prop in properties)
            {
                entityBuilder.IsPropertyValid(prop);
                selectedProperties.Add(prop);
            }

            return this;
        }

        public BaseQueryBuilder<I, E, C> WhereEq(string property, object value)
        {
            Debug.Assert(value != null, "Null value not allowed");

            entityBuilder.IsPropertyValid(property);
            whereProperties.Add(property, value);

            return this;
        }

        public BaseQueryBuilder<I, E, C> WhereIn<T>(string property, params T[] values)
        {
            Debug.Assert(values != null, "Null value not allowed");

            entityBuilder.IsPropertyValid(property);

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

        public BaseQueryBuilder<I, E, C> WhereIn<T>(string property, IList<T> values)
        {
            Debug.Assert(values != null, "Null value not allowed");
            Debug.Assert(values.Count() == 0, "No values provided");

            entityBuilder.IsPropertyValid(property);

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

        public BaseQueryBuilder<I, E, C> Clear()
        {
            selectedProperties.Clear();
            whereInProperties.Clear();
            whereProperties.Clear();

            return this;
        }


        public E Execute()
        {
            C command = this.ToCommand();
            DbDataReader reader = command.ExecuteReader();
            for (int col = 0; col < reader.FieldCount; col++)
            {
                Console.Write(reader.GetName(col).ToString());
                Console.Write(reader.GetFieldType(col).ToString());
                Console.Write(reader.GetDataTypeName(col).ToString());
            }
            return null;
        }


        #region Protected
        protected bool validToBuild()
        {
            return (selectedProperties.Count > 0);
        }
        #endregion

        public abstract String ToQuery();

        public abstract C ToCommand();
    }
}