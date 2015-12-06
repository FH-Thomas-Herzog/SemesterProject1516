using System;

namespace UFO.Server.Data.Api.Attribute
{
    /// <summary>
    /// Attribute which maps an entity property to an physical column
    /// </summary>
    [AttributeUsage(AttributeTargets.Property,
                    AllowMultiple = false,
                    Inherited = true)]
    public class Column : System.Attribute
    {
        /// <summary>
        /// The physical column name
        /// </summary>
        public string Name;
        /// <summary>
        /// True if the column is just read only.
        /// </summary>
        public bool ReadOnly;

        /// <summary>
        /// True if this column is the version marker
        /// </summary>
        public bool Version = false;
    }
}
