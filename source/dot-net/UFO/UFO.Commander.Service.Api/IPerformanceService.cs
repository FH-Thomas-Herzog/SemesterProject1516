using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Service.Api
{
    public interface IPerformanceService : IService
    {
        void Delete(long? id);
        Performance Save(Performance performance);
    }
}
