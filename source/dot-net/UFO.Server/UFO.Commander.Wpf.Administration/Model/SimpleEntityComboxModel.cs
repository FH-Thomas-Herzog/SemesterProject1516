using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class SimpleEntityComboxModel<I, E> where E : class, IEntity<I>
    {
        public E Entity { get; set; }

        public string Label { get; set; }

        public SimpleEntityComboxModel(E entity = null, string label = "")
        {
            this.Entity = entity;
            this.Label = label;
        }

        public override int GetHashCode()
        {
            return (Entity != null) ? Entity.GetHashCode() : base.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            return (Entity != null) ? Entity.Equals(obj) : base.Equals(obj);
        }
    }
}
