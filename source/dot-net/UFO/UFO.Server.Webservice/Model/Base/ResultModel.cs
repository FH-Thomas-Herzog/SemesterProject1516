using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace UFO.Server.Webservice.Soap.Model.Base
{
    public class ResultModel<T> : BaseModel
    {
        public T Result { get; set; }
    }
}