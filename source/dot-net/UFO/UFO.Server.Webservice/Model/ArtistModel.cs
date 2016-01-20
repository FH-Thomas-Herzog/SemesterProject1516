using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UFO.Server.Webservice.Soap.Model.Base;

namespace UFO.Server.Webservice.Soap.Model
{
    [Serializable]
    public class ArtistModel : BaseModel
    {
        public long Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string CountryCode { get; set; }
        public string Url { get; set; }
        public string Image { get; set; }
        public string ImageType { get; set; }
        public string ArtistGroup { get; set; }
        public string ArtistCategory { get; set; }

    }
}