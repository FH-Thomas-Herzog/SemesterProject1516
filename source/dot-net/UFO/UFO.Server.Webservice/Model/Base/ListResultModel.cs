using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace UFO.Server.Webservice.Soap.Model.Base
{
    public class ListResultModel<T> : BaseModel
    {
        public List<T> Result { get; set; }
    }
}