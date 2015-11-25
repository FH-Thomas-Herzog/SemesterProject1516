using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistGroupModel : BaseVersionedEntityPropertyChangeModel<long?, ArtistGroup>
    {
        public ArtistGroupModel(ArtistGroup group) : base(group) { }

        public string Name
        {
            get { return Entity.Name; }
            set { Entity.Name = Name; }
        }

        public string Description
        {
            get { return Entity.Description; }
            set { Entity.Description = Description; }
        }
    }
}
