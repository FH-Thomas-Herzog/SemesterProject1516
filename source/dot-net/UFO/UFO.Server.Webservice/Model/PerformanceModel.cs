using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UFO.Server.Webservice.Soap.Model
{
    [Serializable]
    public class PerformanceModel
    {
        public long? Id { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string FormerStartDate { get; set; }
        public string FormerEndDate { get; set; }
        public string VenueName { get; set; }
        public string ArtistName { get; set; }
        public string ArtistGroupName { get; set; }
        public long? ArtistId { get; set; }
        public long? VenueId { get; set; }
    }
}