using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Db
{
    public interface IDataSource : IDisposable
    {
        DbConnection CreateConnection();
        DbConnection CreateAndOpenConnection();
        void CloseConnection(DbConnection connection);
        void CloseDisposeConnection(DbConnection connection);
    }
}
