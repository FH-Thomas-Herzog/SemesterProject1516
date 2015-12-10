using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Resources;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistModel : BaseVersionedEntityViewModel<long?, Artist>
    {
        public ArtistModel(Artist entity) : base(entity)
        {
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Firstname
        {
            get { return Entity.Firstname; }
            set { Entity.Firstname = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Lastname
        {
            get { return Entity.Lastname; }
            set { Entity.Lastname = value; FirePropertyChangedEvent(); }
        }
        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        [EmailAddress(ErrorMessageResourceName = "ErrorInvalidEmail",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Email
        {
            get { return Entity.Email; }
            set { Entity.Email = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(2,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Country
        {
            get { return Entity.CountryCode; }
            set { Entity.CountryCode = value; FirePropertyChangedEvent(); }
        }

        public string Url
        {
            get { return Entity.Url; }
            set { Entity.Url = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        public ArtistGroup ArtistGroup
        {
            get { return Entity.ArtistGroup; }
            set { Entity.ArtistGroup = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        public ArtistCategory ArtistCategory
        {
            get { return Entity.ArtistCategory; }
            set { Entity.ArtistCategory = value; FirePropertyChangedEvent(); }
        }

        public string Image
        {
            get { return Entity.ImageData; }
            set { Entity.ImageData = value; FirePropertyChangedEvent(); }
        }
    }
}
