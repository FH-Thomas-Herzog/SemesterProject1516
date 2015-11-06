﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Server.Data.Api.Attribute
{
    /// <summary>
    /// Attribute which maps an manyToOne entity.
    /// </summary>
    [AttributeUsage(AttributeTargets.Property,
                    AllowMultiple = false,
                    Inherited = true)]
    public class ManyToOne : System.Attribute
    {

        /// <summary>
        /// The property name which holds the foreign key of the manyToOne entity
        /// </summary>
        public string FkProperty { get; set; }
    }
}