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

namespace UFO.Commander.Wpf.Administration.Views.Security
{
    /// <summary>
    /// Interaction logic for LoginControl.xaml
    /// </summary>
    public partial class LoginControl : UserControl
    {
        public App Application { get { return System.Windows.Application.Current as App; } }

        public ISecurityService securityService;


        public LoginControl()
        {
            InitializeComponent();
        }

        private void OnLoginButtonClick(object sender, RoutedEventArgs e)
        {
            var window = Window.GetWindow(this);
            var user = securityService.Login(Username.Text, Password.Password);
            if (user == null)
            {
                MessageBox.Show(window, Properties.Resources.ErrorLoginFailed, Properties.Resources.ErrorMessage, MessageBoxButton.OK);
            }
            else
            {
                Application.UserContext.LoggedUser = user;
            }
        }

        private void OnVisbilityChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            LoginControl control = sender as LoginControl;

            switch (control.Visibility)
            {
                case Visibility.Visible:
                    securityService = ServiceFactory.CreateSecurityService();
                    break;
                case Visibility.Hidden:
                    ServiceFactory.DisposeService(securityService);
                    break;
                default: break;
            }
        }
    }
}
