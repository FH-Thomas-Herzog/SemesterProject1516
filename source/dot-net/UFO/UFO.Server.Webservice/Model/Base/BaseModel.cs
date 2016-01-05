using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UFO.Server.Webservice.Soap.Model.Base
{
    public enum ErrorCode
    {
        AUTHENTICATION_FAILED=0,
        AUTHENTICATION_MISSING=1,
        ENTRY_NOT_FOUND=2,
        UNKNOWN_ERROR=3
    }
    public class BaseModel
    {
        public int ErrorCode { get; set; }
        public string Error { get; set; }

    }
}