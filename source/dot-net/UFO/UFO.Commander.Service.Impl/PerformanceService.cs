using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Impl.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Service.Impl
{
    public class PerformanceService : BaseService, IPerformanceService
    {
        public PerformanceService(DbConnection connection) : base(connection) { }

        public void Delete(long? id)
        {

        }
        public Performance Save(Performance performance)
        {
            return null;
        }

        protected override void Dispose(bool dispose)
        {
        }
    }
}
