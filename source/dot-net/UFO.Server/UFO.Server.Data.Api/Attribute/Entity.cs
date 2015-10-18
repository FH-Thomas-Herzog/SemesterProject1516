using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Attribute
{
    [AttributeUsage(AttributeTargets.Class,
                AllowMultiple = false)]
    public class Entity : System.Attribute
    {
        public string TableName = "";
        public string Schema = "";
        public string SequenceName = "";
    }
}
