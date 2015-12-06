using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    /// <summary>
    /// UserContext class which represnets a logged or not logged user.
    /// The using application should use a static version of an instance or a singleton because only
    /// one user can be logged on one application instance at the time.
    /// </summary>
    /// <seealso cref="UFO.Commander.Wpf.Administration.Model.Base.BasePropertyChangeModel" />
    public class UserContextModel : BasePropertyChangeModel
    {
        private User user;
        private bool isLogged = false;

        /// <summary>
        /// Gets or sets the logged user.
        /// </summary>
        /// <value>
        /// The logged user.
        /// </value>
        public User LoggedUser
        {
            get { return user; }
            set { if ((this.user = value) != null) { IsLogged = true; } }
        }

        /// <summary>
        /// Gets a value indicating whether a user is logged.
        /// </summary>
        /// <value>
        ///   <c>true</c> if a user is logged; otherwise, <c>false</c>.
        /// </value>
        public bool IsLogged
        {
            get { return isLogged; }
            private set { if ((isLogged = value)) { FirePropertyChangedEvent(); IsNotLogged = !value; } }
        }

        /// <summary>
        /// Gets a value indicating whether a user is not logged.
        /// </summary>
        /// <value>
        /// <c>true</c> if a user is not logged; otherwise, <c>false</c>.
        /// </value>
        public bool IsNotLogged
        {
            get { return !isLogged; }
            private set { if (!(value)) { FirePropertyChangedEvent(); } }
        }
    }
}
