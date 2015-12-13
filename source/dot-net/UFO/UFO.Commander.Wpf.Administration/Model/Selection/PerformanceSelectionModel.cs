using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Server.Data.Api.Entity.View;

namespace UFO.Commander.Wpf.Administration.Model.Selection
{
    public class PerformanceSelectionModel : SimpleObjectModel
    {
        public string Info { get; set; }
        public PerformanceSelectionModel(PerformanceSummaryView view) : base(view)
        {
            Label = view.Date.ToShortDateString();
            Info = $" ({view.ArtistCount}x{Resources.ArtistPl}, {view.VenueCount}x{Resources.VenuePl}, {view.PerformanceCount}x{Resources.PerformancePl})";
        }
    }
}
