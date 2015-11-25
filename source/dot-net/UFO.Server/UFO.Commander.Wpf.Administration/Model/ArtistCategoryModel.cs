using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistCategoryModel : BaseVersionedEntityPropertyChangeModel<long?, ArtistCategory>
    {
        public ArtistCategoryModel(ArtistCategory category) : base(category) { }

        public string Name
        {
            get { return Entity.Name; }
            set { Entity.Name = value; }
        }

        public string Description
        {
            get { return Entity.Description; }
            set { Entity.Description = value; }
        }
    }
}
