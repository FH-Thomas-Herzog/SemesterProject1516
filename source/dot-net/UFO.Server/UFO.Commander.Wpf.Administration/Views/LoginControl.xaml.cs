using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Wpf.Administration.Model;

namespace UFO.Commander.Wpf.Administration.Views
{
    /// <summary>
    /// Interaction logic for LoginControl.xaml
    /// </summary>
    public partial class LoginControl : UserControl
    {
        public readonly App application = Application.Current as App;

        public ISecurityService securityService;


        public LoginControl()
        {
            InitializeComponent();
        }

        public override void BeginInit()
        {
            base.BeginInit();
        }

        private void OnLoginButtonClick(object sender, RoutedEventArgs e)
        {
        }

        private void OnVisbilityChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            LoginControl control = sender as LoginControl;

            switch (control.Visibility)
            {
                case Visibility.Visible:
                    securityService = ServiceFactory.getInstance().getSecurityService();
                    break;
                case Visibility.Hidden:
                    ServiceFactory.getInstance().DisposeService(securityService);
                    break;
                default: break;
            }
        }
    }
}
