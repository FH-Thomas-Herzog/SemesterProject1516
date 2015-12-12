using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public abstract class BaseVersionedEntityViewModel<I, E> : BaseValidationViewModel where E : BaseVersionedEntity<long?, User, I>

    {
        private E _Entity = null;
        private bool _IsDeletable = false;

        protected BaseVersionedEntityViewModel(E entity) : base()
        {
            if(entity == null)
            {
                throw new ArgumentException("BaseVersionedEntityViewModel is not allowed to set null entity");
            }
            this._Entity = entity;
            _IsDeletable = ((_Entity != null) && (_Entity.Id != null));
        }

        public bool IsDeletable
        {
            get { return _IsDeletable; }
            set
            {
                _IsDeletable = value;
                FirePropertyChangedEvent();
            }
        }

        public I Id
        {
            get { return (Entity != null) ? Entity.Id : default(I); }
        }

        public E Entity
        {
            get { return this._Entity; }
            set
            {
                this._Entity = value;
                FirePropertyChangedEvent();
            }
        }

        public DateTime? CreationDate
        {
            get { return this.Entity.CreationDate; }
        }

        public DateTime? ModificationDate
        {
            get { return this.Entity.ModificationDate; }
        }

        public long? Version
        {
            get { return this.Entity.Version; }
        }


        public string CreationUser
        {
            get { return BuildUserString(Entity.CreationUser); }

        }

        public string ModificationUser
        {
            get { return BuildUserString(Entity.ModificationUser); }
        }

        #region Private/Protected Helper
        private string BuildUserString(User user)
        {
            if (Entity?.ModificationUser?.Id != null)
            {
                return string.Format("{0}, {1}", Entity.ModificationUser.LastName, Entity.ModificationUser.FirstName);
            }
            return null;
        }
        public abstract E GetUpdatedEntity();
        #endregion
    }
}
