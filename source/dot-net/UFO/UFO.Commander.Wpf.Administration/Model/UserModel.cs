using System;
using System.Resources;
using System.ComponentModel.DataAnnotations;
using UFO.Server.Data.Api.Entity;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Properties;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class UserModel : BaseVersionedEntityViewModel<long?, User>
    {
        public UserModel(User user) : base(user)
        {
            // TODO: Add initialization for new user entity here
            if (user.Id == null)
            {
                user.Type = User.UserType.ARTIST;
            }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        public string Firstname
        {
            get { return Entity.FirstName; }
            set { Entity.FirstName = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        public string Lastname
        {
            get { return Entity.LastName; }
            set { Entity.LastName = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(ResourceManager))]
        // TODO: Add custom validator for checking against database
        public string Username
        {
            get { return Entity.Username; }
            set { Entity.Username = value; FirePropertyChangedEvent(); }
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
            set { Entity.Email = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
              ErrorMessageResourceType = typeof(ResourceManager))]
        [StringLength(100,
                  MinimumLength = 1,
                  ErrorMessageResourceName = "ErrorInvalidStringLength",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [EmailAddress(ErrorMessageResourceName = "ErrorInvalidEmail",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        [Compare("Email")]
        public string EmailRepeation
        {
            get { return EmailRepeation; }
            set { EmailRepeation = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(ResourceManager))]
        public User.UserType? UserType
        {
            get { return Entity.Type; }
            set { Entity.Type = value; FirePropertyChangedEvent(); }
        }
    }
}
