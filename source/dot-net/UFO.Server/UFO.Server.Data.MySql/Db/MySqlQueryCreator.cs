using System.Collections.Generic;
using System.Linq;
using System.Text;
using UFO.Server.Data.Api.Db;

namespace UFO.Server.Data.MySql.Db
{
    /// <summary>
    /// MySql implementation for the IQuery interface
    /// </summary>
    public class MySqlQueryCreator : IQueryCreator
    {
        private const string SELECT_ID_BY_ID_TEMPLATE = @"SELECT {1} FROM {0} WHERE {1} = ?id";
        private const string SELECT_ID_BY_ID_VERSIONED_TEMPLATE = SELECT_BY_ID_TEMPLATE + @" AND {2} = ?version ";
        private const string SELECT_BY_ID_TEMPLATE = @"SELECT * FROM {0} WHERE {1} = ?id";
        private const string DELETE_BY_ID_TEMPLATE = @"DELETE FROM {0} WHERE {1} = ?id";
        private const string INSERT_TEMPLATE = @"INSERT INTO {0} ({1}) VALUES({2}); SELECT CAST(LAST_INSERT_ID() AS SIGNED INTEGER);";
        private const string UPDATE_TEMPLATE = @"UPDATE {0} SET {1} WHERE {2} = ?id";
        private const string NEXT_VAL_TEMPLATE = @"SELECT NEXT VALUE for {0}";

        string IQueryCreator.CreateFullSelectQuery<I, E>()
        {
            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            return string.Format(SELECT_BY_ID_TEMPLATE, metamodel.GetFullyQualifiedPhysicalTableName(), metamodel.GetIdColumnName());
        }

        string IQueryCreator.CreateIdSelectQuery<I, E>()
        {
            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            return string.Format(SELECT_BY_ID_TEMPLATE, metamodel.GetFullyQualifiedPhysicalTableName(), metamodel.GetIdColumnName());
        }
        string IQueryCreator.CreateIdVersionedSelectQuery<I, E>()
        {
            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            return string.Format(SELECT_BY_ID_TEMPLATE, metamodel.GetFullyQualifiedPhysicalTableName(), metamodel.GetIdColumnName());
        }

        string IQueryCreator.CreatePersistQuery<I, E>(E entity, IDictionary<string, object> propertyToValueMap)
        {
            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            StringBuilder parameters = new StringBuilder();
            StringBuilder values = new StringBuilder();
             for (int i = 0; i < propertyToValueMap.Count; i++)
            {
                KeyValuePair<string, object> pair = propertyToValueMap.ElementAt(i);
                parameters.Append(metamodel.PropertyToColumn(pair.Key))
                          .Append((i < (propertyToValueMap.Count - 1)) ? " , " : "");

                values.Append("?")
                      .Append(pair.Key)
                      .Append((i < (propertyToValueMap.Count - 1)) ? " , " : "");
            }

            return string.Format(INSERT_TEMPLATE, metamodel.GetFullyQualifiedPhysicalTableName(), parameters, values);
        }

        string IQueryCreator.CreateUpdateQuery<I, E>(E entity, IDictionary<string, object> propertyToValueMap)
        {
            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            StringBuilder sb = new StringBuilder();
             for (int i = 0; i < propertyToValueMap.Count; i++)
            {
                KeyValuePair<string, object> pair = propertyToValueMap.ElementAt(i);
                sb.Append(metamodel.PropertyToColumn(pair.Key))
                  .Append(" = ")
                  .Append("?")
                  .Append(pair.Key)
                  .Append((i < (propertyToValueMap.Count - 1)) ? ", " : "");
            }

            return string.Format(UPDATE_TEMPLATE, metamodel.GetFullyQualifiedPhysicalTableName(), sb, metamodel.GetIdColumnName());
        }
        string IQueryCreator.CreateDeleteQuery<I, E>()
        {
            EntityMetamodel<I, E> metamodel = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
            return string.Format(DELETE_BY_ID_TEMPLATE, metamodel.GetFullyQualifiedPhysicalTableName(), metamodel.GetIdColumnName());
        }
}
}
