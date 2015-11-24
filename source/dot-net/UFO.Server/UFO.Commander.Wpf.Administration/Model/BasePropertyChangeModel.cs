using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Wpf.Administration.Model
{
    public abstract class BasePropertyChangeModel
    {
        public event PropertyChangedEventHandler PropertyChanged;

        // Uses caller member name or provided one which allows call in the following format
        // bean.RaisePropertyChangedEvent();
        protected void FirePropertyChangedEvent([CallerMemberName] string propertyName = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
