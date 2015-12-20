using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Service.Api.Exception
{
    public class ServiceException : System.Exception
    {
        public int ErrorCode { get; private set; }
        public ServiceException(int errorCode) : this(errorCode, null, null) { }
        public ServiceException() { }
        public ServiceException(string message) : base(message) { }
        public ServiceException(string message, System.Exception inner) : base(message, inner) { }

        public ServiceException(int errorCode, string message, System.Exception inner) : this(message, inner)
        {
            this.ErrorCode = errorCode;
        }
        protected ServiceException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context)
        { }

    }
}
