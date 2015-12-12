using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace UFO.Commander.Wpf.Administration.Views.Util
{
    public class MessageHandler : IMessageHandler
    {
        public void ShowMessage(string header, string message)
        {
            ShowMessage(header, message, null, null);
        }

        public void ShowErrorMessage(string message)
        {
            ShowErrorMessage(message, null);
        }

        public void ShowErrorMessage(string message, Action okAction)
        {
            MessageBoxResult result = MessageBox.Show(message, Administration.Properties.Resources.ErrorMessage, MessageBoxButton.OK);
            if (result.Equals(MessageBoxResult.OK))
            {
                InvokeAction(okAction);
            }
        }

        public void ShowMessage(string header, string message, Action yesAction, Action noAction)
        {
            MessageBoxResult result = MessageBox.Show(message, header ?? "", MessageBoxButton.YesNo);
            switch (result)
            {
                case MessageBoxResult.Yes:
                    InvokeAction(yesAction);
                    break;
                case MessageBoxResult.No:
                    InvokeAction(noAction);
                    break;
            }
        }

        private void InvokeAction(Action action)
        {
            if (action != null)
            {
                action();
            }
        }
    }
}
