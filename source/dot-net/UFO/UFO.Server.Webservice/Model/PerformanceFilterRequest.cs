using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace UFO.Server.Webservice.Soap.Model
{
    [Serializable]
    public class PerformanceFilterRequest
    {
        private DateTime _StartDate;
        private DateTime _EndDate;
        [XmlElement(DataType = "dateTime", IsNullable = false)]
        public DateTime StartDate { get { return _EndDate; } set { _EndDate = DateTime.SpecifyKind(value, DateTimeKind.Utc); } }

        [XmlElement(DataType = "dateTime", IsNullable = false)]
        public DateTime EndDate { get { return _StartDate; } set { _StartDate = DateTime.SpecifyKind(value, DateTimeKind.Utc); } }

        [XmlElement(IsNullable = true)]
        public List<long?> ArtistIds { get; set; }

        [XmlElement(IsNullable = true)]
        public List<long?> VenueIds { get; set; }

        [XmlElement(IsNullable = true)]
        public List<long?> ArtistGroupIds { get; set; }

        [XmlElement(IsNullable = true)]
        public List<long?> ArtistCategoryIds { get; set; }

        [XmlElement(IsNullable = true)]
        public List<string> Countries { get; set; }

        [XmlElement(IsNullable = true)]
        public bool? Moved { get; set; }
    }
}