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
    public class VenueService : BaseService, IVenueService
    {
        public VenueService(DbConnection connection = null) : base(connection)
        {

        }

        protected override void Dispose(bool dispose)
        {

        }
    }
}
