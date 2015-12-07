using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api.Base;
using UFO.Server.Data.Api.Db;
using UFO.Server.Data.Api.Exception;

namespace UFO.Commander.Service.Impl.Base
{
    public class BaseService : IService
    {
        protected DbConnection Connection { get; set; }
        protected DbTransaction Transaction { get; set; }

        public BaseService(DbConnection connection = null)
        {
            Connection = connection ?? DbConnectionFactory.CreateAndOpenConnection();
        }

        public void StartTx(IsolationLevel level = IsolationLevel.ReadCommitted)
        {
            Transaction = Connection.BeginTransaction(level);
        }

        public void CommitTx()
        {
            if (Transaction == null)
            {
                throw new PersistenceException("No transaction is open for commit");
            }
            Transaction.Commit();
        }

        public void RollbackTx()
        {
            if (Transaction == null)
            {
                throw new PersistenceException("No transaction is open for rollback");
            }
            Transaction.Rollback();
        }

        public virtual void Dispose()
        {
            Transaction?.Dispose();
            DbConnectionFactory.CloseDisposeConnection(Connection);
        }
    }
}
