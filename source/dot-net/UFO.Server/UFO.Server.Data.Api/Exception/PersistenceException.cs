using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Exception
{

    /// <summary>
    /// Own exception for indicating that an entity hasn't been found.
    /// </summary>
    public class PersistenceException : System.Exception
    {
        public PersistenceException() { }
        public PersistenceException(string message) : base(message) { }
        public PersistenceException(string message, System.Exception inner) : base(message, inner) { }
        protected PersistenceException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context)
        { }
    }
}
