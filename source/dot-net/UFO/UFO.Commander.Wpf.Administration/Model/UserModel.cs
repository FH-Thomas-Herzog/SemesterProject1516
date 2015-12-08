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
        public UserModel(User user = null) : base(user)
        {
            // TODO: Add initialization for new user entity here
            if (Entity == null)
            {
                Entity = new User();
            }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Firstname
        {
            get { return Entity.FirstName; }
            set { Entity.FirstName = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Lastname
        {
            get { return Entity.LastName; }
            set { Entity.LastName = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        // TODO: Add custom validator for checking against database
        public string Username
        {
            get { return Entity.Username; }
            set { Entity.Username = value; FirePropertyChangedEvent(); }
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
        [StringLength(100,
                  MinimumLength = 1,
                  ErrorMessageResourceName = "ErrorInvalidStringLength",
                  ErrorMessageResourceType = typeof(Resources))]
        [EmailAddress(ErrorMessageResourceName = "ErrorInvalidEmail",
                  ErrorMessageResourceType = typeof(Resources))]
        [Compare("Email")]
        public string EmailRepeation
        {
            get { return EmailRepeation; }
            set { EmailRepeation = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        public User.UserType? UserType
        {
            get { return Entity.Type; }
            set { Entity.Type = value; FirePropertyChangedEvent(); }
        }
    }
}
