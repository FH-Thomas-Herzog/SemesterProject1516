using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Entity.View
{
    public class PerformanceSummaryView
    {
        public DateTime Date { get; set; }
        public int ArtistCount { get; set; }
        public int VenueCount { get; set; }
        public int PerformanceCount { get; set; }

        public override string ToString()
        {
            return new StringBuilder(Date.ToString("d")).Append(" (")
                                                     .Append(ArtistCount).Append("x{0}").Append(", ")
                                                     .Append(VenueCount).Append("x{1}").Append(", ")
                                                     .Append(PerformanceCount).Append("x{2})").ToString();
        }
    }
}
