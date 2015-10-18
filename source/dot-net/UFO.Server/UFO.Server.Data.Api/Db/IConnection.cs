using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Db
{
    public interface IConnection<C, CMD> where C : DbConnection where CMD : DbCommand
    {
        C GetConnection();

        void CloseConnection(C connection);
    }
}
