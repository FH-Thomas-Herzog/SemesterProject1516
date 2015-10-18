using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Db
{
    public interface IDbTypeResolver<T>
    {
        T resolve(Type type);
    }
}
