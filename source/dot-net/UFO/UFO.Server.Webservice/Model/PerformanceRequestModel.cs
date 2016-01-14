using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using UFO.Server.Webservice.Soap.Model.Base;

namespace UFO.Server.Webservice.Soap.Model
{
    public class PerformanceRequestModel : BaseModel
    {
        private DateTime _StartDate;

        public string Username { get; set; }
        public string Password { get; set; }
        public long? Id { get; set; }
        public long? Version { get; set; }
        public long ArtistId { get; set; }
        public long VenueId { get; set; }
        public string Locale{ get; set; }
        public DateTime StartDate { get { return _StartDate; } set { _StartDate = DateTime.SpecifyKind(value, DateTimeKind.Utc); } }
    }
}