using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public abstract class BaseTabModel<M> : BasePropertyChangeModel, ITabModel where M : BasePropertyChangeModel
    {
        private string header;
        private M model;
        public string Header { get { return header; } set { header = value; FirePropertyChangedEvent(); } }
        public BasePropertyChangeModel ViewModel { get { return model; } set { this.model = value as M; FirePropertyChangedEvent(); } }

        public abstract void Init(BasePropertyChangeModel model);
        public abstract void Destroy();

    }
}
