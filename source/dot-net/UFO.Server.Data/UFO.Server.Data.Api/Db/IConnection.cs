using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Db
{
    public interface IConnection<C, CMD> where C : IDbConnection where CMD : IDbCommand
    {
        C OpenConnection();

        void CloseConnection(C connection);

        CMD CreateCommand(string command);
    }
}
