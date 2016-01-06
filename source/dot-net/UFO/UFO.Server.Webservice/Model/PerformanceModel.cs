using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using UFO.Server.Webservice.Soap.Model.Base;

namespace UFO.Server.Webservice.Soap.Model
{
    [Serializable]
    public class PerformanceModel: BaseModel
    {
        public long Id { get; set; }

        [XmlElement(DataType = "dateTime", IsNullable = false)]
        public DateTime StartDate { get; set; }

        [XmlElement(DataType = "dateTime", IsNullable = false)]
        public DateTime EndDate { get; set; }

        public bool Moved { get; set; }

        public string VenueName { get; set; }

        public string ArtistName { get; set; }

        public string ArtistGroupName { get; set; }

        public long? ArtistId { get; set; }

        public long? ArtistGroupId { get; set; }

        public long VenueId { get; set; }
    }
}