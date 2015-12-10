using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public interface ITabedViewModel<M> : ITabModel where M :BasePropertyChangeModel
    {
        M ViewModel { get; set; }
        void Init(M model);
    }
}
