using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Attribute
{
    /// <summary>
    /// Attribute which maps an entity to an physical database table.
    /// </summary>
    [AttributeUsage(AttributeTargets.Class,
                AllowMultiple = false)]
    public class Entity : System.Attribute
    {
        /// <summary>
        /// The physical entity table name
        /// </summary>
        public string TableName = "";

        /// <summary>
        /// The physical entity schema name
        /// </summary>
        public string Schema = "";

        /// <summary>
        /// The physical entity seuence name
        /// </summary>
        public string SequenceName = "";
    }
}
