﻿using System;
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
        private bool _IsUpdateable = true;

        protected BaseVersionedEntityViewModel(E entity) : base()
        {
            if (entity == null)
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

        public bool IsUpdateable
        {
            get { return _IsUpdateable; }
            set { _IsUpdateable = value; FirePropertyChangedEvent(); }
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

        #region Private/Protected Helper
        public abstract E GetUpdatedEntity();
        #endregion
        public override bool Equals(object obj)
        {
            // Type check
            if ((obj != null) && (obj.GetType() == this.GetType()))
            {
                BaseVersionedEntityViewModel<I, E> other = (BaseVersionedEntityViewModel<I, E>)obj;
                if (Id == null)
                {
                    // Use object id if boths ids are null
                    if (other.Id == null)
                    {
                        return base.Equals(other);
                    }
                }
                else
                {
                    // Both hold the same Id 
                    return Id.Equals(other.Id);
                }
            }
            return false;
        }
    }
}
