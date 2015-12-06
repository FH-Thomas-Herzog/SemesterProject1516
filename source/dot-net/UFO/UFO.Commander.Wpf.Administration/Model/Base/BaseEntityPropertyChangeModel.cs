using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public abstract class BaseEntityPropertyChangeModel<I, E> : BasePropertyChangeModel where E : BaseEntity<I>
    {
        public I Id
        {
            get
            {
                return (this.Entity != null) ? this.Entity.Id : default(I);
            }
        }

        public E Entity
        {
            get
            {
                return this.Entity;
            }
            set
            {
                this.Entity = value;
            }
        }
    }
}
