using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public abstract class BaseVersionedEntityPropertyChangeModel<I, E> : BasePropertyChangeModel where E : BaseVersionedEntity<long?, User, I>

    {
        protected BaseVersionedEntityPropertyChangeModel(E entity)
        {
            if (entity == null)
            {
                throw new ArgumentException(string.Format("Model class: '{0}' needs an entity instance set", this.GetType().Name));
            }
        }
        public I Id
        {
            get
            {
                return (Entity != null) ? Entity.Id : default(I);
            }
        }

        public E Entity
        {
            get
            {
                return this.Entity;
            }
        }

        public DateTime? CreationDate
        {
            get
            {
                return this.Entity?.CreationDate;
            }
        }

        public DateTime? ModificationDate
        {
            get
            {
                return this.Entity?.ModificationDate;
            }
        }

        public long? Version
        {
            get
            {
                return this.Entity?.Version;
            }
        }


        public string CreationUser
        {
            get
            {
                return BuildUserString(Entity.CreationUser);
            }

        }

        public string ModificationUser
        {
            get
            {
                return BuildUserString(Entity.ModificationUser);
            }
        }

        #region Private Helper
        private string BuildUserString(User user)
        {
            if (Entity?.ModificationUser?.Id != null)
            {
                return string.Format("{0}, {1}", Entity.ModificationUser.LastName, Entity.ModificationUser.FirstName);
            }
            return null;
        }
        #endregion
    }
}
