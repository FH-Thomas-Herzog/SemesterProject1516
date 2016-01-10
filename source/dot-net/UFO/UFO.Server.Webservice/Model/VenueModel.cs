using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UFO.Server.Webservice.Soap.Model.Base;

namespace UFO.Server.Webservice.Soap.Model
{
    [Serializable]
    public class VenueModel : BaseModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string FullAddress { get; set; }
        public string GpsCoordinates { get; set; }
        public List<PerformanceModel> Performances { get; set; }
    }
}