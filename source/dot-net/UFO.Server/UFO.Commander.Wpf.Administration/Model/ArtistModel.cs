using System.ComponentModel.DataAnnotations;
using System.Resources;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistModel : BaseVersionedEntityViewModel<long?, Artist>
    {
        public ArtistModel(Artist entity) : base(entity)
        {
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        public string Firstname
        {
            get { return Entity.Firstname; }
            set { Entity.Firstname = value; }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        public string Lastname
        {
            get { return Entity.Lastname; }
            set { Entity.Lastname = value; }
        }
        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        [EmailAddress(ErrorMessageResourceName = "ErrorInvalidEmail",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        public string Email
        {
            get { return Entity.Email; }
            set { Entity.Email = value; }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(2,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        public string Country
        {
            get { return Entity.CountryCode; }
            set { Entity.CountryCode = value; }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        public ArtistGroup ArtistGroup
        {
            get { return Entity.ArtistGroup; }
            set { Entity.ArtistGroup = value; }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        public ArtistCategory ArtistCategory
        {
            get { return Entity.ArtistCategory; }
            set { Entity.ArtistCategory = value; }
        }

        public string Image
        {
            get { return Entity.ImageData; }
            set { Entity.ImageData = value; }
        }
    }
}
