using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistModel : BaseVersionedEntityPropertyChangeModel<long?, Artist>
    {
        protected ArtistModel(Artist entity) : base(entity)
        {
        }

        public string Firstname
        {
            get
            {
                return Entity.Firstname;
            }
            set
            {
                Entity.Firstname = value;
            }
        }

        public string Lastname
        {
            get
            {
                return Entity.Lastname;
            }
            set
            {
                Entity.Lastname = value;
            }
        }
        public string Email
        {
            get
            {
                return Entity.Email;
            }
            set
            {
                Entity.Email = value;
            }
        }

        public SimpleObjectComboboxModel<string> Country
        {
            get
            {
                return new SimpleObjectComboboxModel<string>(Entity.CountryCode, Entity.CountryCode);
            }
            set
            {
                Entity.CountryCode = value?.Data;
            }
        }

        public SimpleEntityComboxModel<long?, ArtistGroup> ArtistGroup
        {
            get
            {
                return new SimpleEntityComboxModel<long?, ArtistGroup>(Entity.ArtistGroup, Entity.Lastname);
            }
            set
            {
                Entity.ArtistGroup = value?.Entity;
            }
        }

        public SimpleEntityComboxModel<long?, ArtistCategory> ArtistCategory
        {
            get
            {
                return new SimpleEntityComboxModel<long?, ArtistCategory>(Entity.ArtistCategory, Entity.Lastname);
            }
            set
            {
                Entity.ArtistCategory = value?.Entity;
            }
        }
    }
}
