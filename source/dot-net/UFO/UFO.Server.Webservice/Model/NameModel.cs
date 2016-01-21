using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UFO.Server.Webservice.Soap.Model.Base;

namespace UFO.Server.Webservice.Soap.Model
{
    public class NameModel<T> : BaseModel
    {
        public T Id { get; set; }

        public string Name { get; set; }
    }
}