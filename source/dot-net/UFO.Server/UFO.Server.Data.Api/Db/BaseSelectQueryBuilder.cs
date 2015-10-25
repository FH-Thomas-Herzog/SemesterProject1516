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
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Db
{
    public abstract class BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE>
                                                                                        where ENTITY : class, IEntity<ID>
                                                                                        where DBCMD : DbCommand
                                                                                        where DBPARAM : DbParameter
                                                                                        where DBCON : DbConnection
                                                                                        where ICON : IConnection<DBCON, DBCMD>
                                                                                        where CMDBUILDER : BaseDbCommandBuilder<DBCON, ICON, DBCMD, DBPARAM, DBTYPE>
    {
        protected ISet<string> selectedProperties = new HashSet<string>();
        protected IList<IDictionary<string, BaseWhereBuilder<ID, ENTITY>>> whereClause = new List<IDictionary<string, BaseWhereBuilder<ID, ENTITY>>>();
        protected IList<IDictionary<string, object>> whereProperties = new List<IDictionary<string, object>>();
        protected IDictionary<string, ISet<object>> whereInProperties = new Dictionary<string, ISet<object>>();

        protected Type type;
        protected EntityBuilder<ID, ENTITY> entityBuilder;
        protected CMDBUILDER commandBuilder;

        public BaseSelectQueryBuilder()
        {
            Init();
        }

        public void Init()
        {
            Clear();
            entityBuilder = new EntityBuilder<ID, ENTITY>().Init();
        }

        public BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE> WithDbCommandBuilder(CMDBUILDER builder)
        {
            Debug.Assert(builder != null, "Cannot use null command builder");

            commandBuilder = builder;

            return this;
        }

        public BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE> SelectAll()
        {
            foreach (var key in entityBuilder.PropertyToColumn.Keys)
            {
                selectedProperties.Add(key);
            }

            return this;
        }
        public BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE> Select(params String[] properties)
        {
            foreach (var prop in properties)
            {
                if (!entityBuilder.IsPropertyValid(prop))
                {
                    throw new System.Exception(string.Format("Property '{0}' no mapped", prop));
                }
                selectedProperties.Add(prop);
            }

            return this;
        }

        public BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE> WhereEq(string property, object value)
        {
            Debug.Assert(value != null, "Null value not allowed");

            if (!entityBuilder.IsPropertyValid(property))
            {
                throw new System.Exception(string.Format("Property '{0}' no mapped", property));
            }
            IDictionary<string, object> mapping = new Dictionary<string, object>();
            mapping[property] = value;
            whereProperties.Add(mapping);

            return this;
        }

        public BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE> WhereIn<T>(string property, params T[] values)
        {
            Debug.Assert(values != null, "Null value not allowed");

            if (!entityBuilder.IsPropertyValid(property))
            {
                throw new System.Exception(string.Format("Property '{0}' no mapped", property));
            }

            ISet<object> listValues = new HashSet<object>();
            foreach (var value in values)
            {
                if (value == null)
                {
                    throw new ArgumentException("Null value not allowed");
                }
                listValues.Add(value);
            }

            whereInProperties.Add(property, listValues);

            return this;
        }

        public BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE> WhereIn<T>(string property, ISet<T> values)
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

            whereInProperties.Add(property, (ISet<object>)values);

            return this;
        }

        public BaseSelectQueryBuilder<ID, ENTITY, DBCMD, DBCON, ICON, DBPARAM, CMDBUILDER, DBTYPE> Clear()
        {
            selectedProperties.Clear();
            whereInProperties.Clear();
            whereProperties.Clear();

            return this;
        }


        public abstract ENTITY Execute();


        #region Protected
        protected bool validToBuild()
        {
            return (selectedProperties.Count > 0);
        }
        #endregion

        public abstract String ToQuery();

        public abstract DBCMD ToCommand();
    }
}