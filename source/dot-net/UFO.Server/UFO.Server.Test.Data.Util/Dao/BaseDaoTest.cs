using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Db;

namespace UFO.Server.Test.Data.MySql.Dao
{
    public class BaseDaoTest<I, E, D> where E : class, IEntity<I> where D : class, IDao<I, E>
    {
        protected D dao = (D)Activator.CreateInstance(typeof(D));
        protected EntityMetamodel<I, E> metadata = EntityMetamodelFactory.GetInstance().GetMetaModel<I, E>();
        protected EntityBuilder<I, E> entityBuidler = new EntityBuilder<I, E>();
        protected MySqlDbCommandBuilder builder = new MySqlDbCommandBuilder();

        protected E ById(long? id)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT * FROM ").Append(metadata.GetFullyQualifiedPhysicalTableName())
              .Append(" WHERE ").Append(metadata.GetIdColumnName()).Append(" = @id");
            IDataReader reader = builder.WithConnection(DbConnectionFactory.CreateAndOpenConnection<MySqlConnection>())
                   .WithTypeResolver(new MySqlDbTypeResolver())
                   .WithQuery(sb.ToString())
                   .SetParameter("@id", id)
                   .ExecuteReader(CommandBehavior.Default);
            reader.Read();
            return entityBuidler.CreateFromReader(reader);
        }
    }
}
