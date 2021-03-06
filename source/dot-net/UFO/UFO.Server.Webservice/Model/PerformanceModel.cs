﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using UFO.Server.Webservice.Soap.Model.Base;

namespace UFO.Server.Webservice.Soap.Model
{
    [Serializable]
    public class PerformanceModel : BaseModel
    {
        public long Id { get; set; }
        public long Version { get; set; }

        [XmlElement(DataType = "dateTime", IsNullable = false)]
        public DateTime StartDate { get; set; }

        [XmlElement(DataType = "dateTime", IsNullable = false)]
        public DateTime EndDate { get; set; }

        [XmlElement(DataType = "dateTime", IsNullable = true)]
        public DateTime? FormerStartDate { get; set; }

        [XmlElement(DataType = "dateTime", IsNullable = true)]
        public DateTime? FormerEndDate { get; set; }

        public ArtistModel Artist { get; set; }

        public VenueModel Venue { get; set; }

        [XmlElement(IsNullable = true)]
        public VenueModel FormerVenue { get; set; }
    }
}