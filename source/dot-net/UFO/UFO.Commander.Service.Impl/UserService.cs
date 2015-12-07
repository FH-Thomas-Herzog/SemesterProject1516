using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Impl.Base;

namespace UFO.Commander.Service.Impl
{
    public class UserService : BaseService, IUserService
    {
        public UserService(DbConnection connection = null) : base(connection)
        {

        }
    }
}
