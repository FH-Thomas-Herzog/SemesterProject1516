using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Attribute
{
    [AttributeUsage(AttributeTargets.Property,
                    AllowMultiple = false,
                    Inherited = true)]
    public class Column : System.Attribute
    {
        public string Name = "";
    }
}
