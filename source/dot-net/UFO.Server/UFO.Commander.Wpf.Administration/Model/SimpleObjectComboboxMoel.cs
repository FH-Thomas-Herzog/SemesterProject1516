using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class SimpleObjectComboboxModel<E> where E : class
    {
        public E Data { get; set; }

        public string Label { get; set; }

        public SimpleObjectComboboxModel(E data = null, string label = "")
        {
            this.Data = data;
            this.Label = label;
        }

        public override int GetHashCode()
        {
            return (Data != null) ? Data.GetHashCode() : base.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            return (Data != null) ? Data.Equals(obj) : base.Equals(obj);
        }
    }
}
