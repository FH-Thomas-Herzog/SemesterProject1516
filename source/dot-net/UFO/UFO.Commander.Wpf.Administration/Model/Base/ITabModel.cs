using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public interface ITabModel
    {
        string Header { get; set; }
        void InitTab();
        void CleanupTab();
        void SelectionChanged();
    }
}
