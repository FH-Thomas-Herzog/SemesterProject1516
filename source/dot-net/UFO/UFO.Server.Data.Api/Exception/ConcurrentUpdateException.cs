using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Exception
{
    public class ConcurrentUpdateException : PersistenceException
    {
        public ConcurrentUpdateException()
        {
        }

        public ConcurrentUpdateException(string message) : base(message)
        {
        }

        public ConcurrentUpdateException(string message, System.Exception inner) : base(message, inner)
        {
        }

        protected ConcurrentUpdateException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
