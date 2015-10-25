using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Attribute
{
    public enum PkType
    {
        MANUAL = 0,
        SEQUENCE = 1,
        AUTO = 2
    }

    [AttributeUsage(AttributeTargets.Property,
                    AllowMultiple = false,
                    Inherited = true)]
    public class Id : System.Attribute
    {

        public PkType PkType = PkType.MANUAL;
        public bool Fk = false;
        public bool manyToOne = false;
        public bool oneToMany = false;
    }
}
