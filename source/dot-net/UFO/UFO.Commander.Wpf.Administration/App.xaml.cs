using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        // There can only be one user context at the time per application
        private static UserContextModel userContext = new UserContextModel();
        public UserContextModel UserContext { get { return App.userContext; } }

        private void OnApplicationStart(object sender, StartupEventArgs e)
        {
        }

    }


}
