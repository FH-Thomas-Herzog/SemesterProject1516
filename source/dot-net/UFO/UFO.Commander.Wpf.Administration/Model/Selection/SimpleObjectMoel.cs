using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Selection
{
    public class SimpleObjectModel
    {
        public object Data { get; set; }

        public string Label { get; set; }

        public SimpleObjectModel(object data = null, string label = "")
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
            return (Data != null) ? Data.Equals((obj as SimpleObjectModel)?.Data) : base.Equals(obj);
        }
    }
}
