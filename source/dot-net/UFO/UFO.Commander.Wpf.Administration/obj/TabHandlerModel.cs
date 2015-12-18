using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class TabHandlerModel : BasePropertyChangeModel
    {
        private int selectedIndex = 0;
        public int SelectedIndex { get { return selectedIndex; } set { selectedIndex = value; FirePropertyChangedEvent(); } }


    }
}
