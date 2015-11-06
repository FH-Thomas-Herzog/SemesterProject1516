using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Attribute
{
    /// <summary>
    /// Enumeration whic specifies the type of the pk.
    /// </summary>
    public enum PkType
    {
        MANUAL = 0,
        AUTO = 1
    }

    /// <summary>
    /// Attribute which maps an entity property to an table id.
    /// </summary>
    [AttributeUsage(AttributeTargets.Property,
                    AllowMultiple = false,
                    Inherited = true)]
    public class Id : System.Attribute
    {
        /// <summary>
        /// The primary key type.
        /// </summary>
        public PkType PkType = PkType.MANUAL;
    }
}
