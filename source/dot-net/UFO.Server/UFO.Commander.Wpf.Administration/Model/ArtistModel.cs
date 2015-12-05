using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistModel : BaseVersionedEntityViewModel<long?, Artist>
    {
        public ArtistModel(Artist entity) : base(entity)
        {
        }

        public string Firstname
        {
            get { return Entity.Firstname; }
            set { Entity.Firstname = value; }
        }

        public string Lastname
        {
            get { return Entity.Lastname; }
            set { Entity.Lastname = value; }
        }
        public string Email
        {
            get { return Entity.Email; }
            set { Entity.Email = value; }
        }

        //public SimpleObjectModel<string> Country
        //{
        //    get { return new SimpleObjectModel<string>(Entity.CountryCode, Entity.CountryCode); }
        //    set { Entity.CountryCode = value?.Data; }
        //}

        public ArtistGroup ArtistGroup
        {
            get { return Entity.ArtistGroup; }
            set { Entity.ArtistGroup = value; }
        }

        public ArtistCategory ArtistCategory
        {
            get { return Entity.ArtistCategory; }
            set { Entity.ArtistCategory = value; }
        }
    }
}
