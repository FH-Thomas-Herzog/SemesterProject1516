using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Service.Api
{
    public enum PerformanceErrorCode
    {
        PERFORMANCE_ALREADY_STARTED = 0,
        PERFORMANCE_DATE_INVALID = 1,
        ARTIST_OVERBOOKED = 2,
        NOTIFICATION_ERROR= 3,
        VENUE_OVERBOOKED = 4
    };

    public interface IPerformanceService : IService
    {
        void Delete(long? id);
        Performance Save(Performance performance, int hourOffset);
        int Notify(string subject, string content);
    }
}
