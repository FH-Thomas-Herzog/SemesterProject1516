using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace UFO.Commander.Wpf.Administration.Views.Util
{
    public interface IMessageHandler
    {
        void ShowMessage(string header, string message, Action yesAction, Action noAction);
        void ShowErrorMessage(string message, Action okAction);
        void ShowMessage(string header, string message);
        void ShowErrorMessage(string message);
    }
}
