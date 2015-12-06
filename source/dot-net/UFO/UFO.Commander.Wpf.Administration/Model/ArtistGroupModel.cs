using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistGroupModel : BaseVersionedEntityViewModel<long?, ArtistGroup>
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
