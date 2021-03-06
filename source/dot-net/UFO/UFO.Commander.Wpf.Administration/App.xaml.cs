﻿using System;
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

        /// <summary>
        /// Called when [application start].
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="StartupEventArgs"/> instance containing the event data.</param>
        private void OnApplicationStart(object sender, StartupEventArgs e)
        {
        }

        /// <summary>
        /// Called when [unhandled exception].
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.Windows.Threading.DispatcherUnhandledExceptionEventArgs" /> instance containing the event data.</param>
        private void OnUnhandledException(object sender, System.Windows.Threading.DispatcherUnhandledExceptionEventArgs e)
        {
            Exception ex = e.Exception;
            if (ex != null)
            {
                MessageBox.Show(MainWindow, Administration.Properties.Resources.ErrorUnknwon + $" (errorMessage={ex.Message})", Administration.Properties.Resources.ErrorMessage, MessageBoxButton.OK);
            }
            e.Handled = true;
        }
    }


}
