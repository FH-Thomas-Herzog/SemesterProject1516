using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Views.Util;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public interface ITabModel
    {
        string Header { get; }
        void InitTab(IMessageHandler messageHandler);
        void CleanupTab();
        void SelectionChanged();
    }
}
