﻿using System;
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
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public int SelectedTabIdx { get; set; }
        public User LoggedUser { get; set; }
        public bool IsLogged { get { return LoggedUser != null; } }
        // TODO: Hold reference to currently selected tab backed handler

        public readonly App application = Application.Current as App;


        public MainWindow()
        {
            InitializeComponent();
        }

        private void ArtistMasterData_Loaded(object sender, RoutedEventArgs e)
        {

        }

        /// <summary>
        /// Called when [tab change]. 
        /// Prepares the backing tab handler and clears the former used handler and itsloaded data.
        /// </summary>
        /// <param name="sender">The sender which represents the selected tab</param>
        /// <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
        private void OnTabChange(object sender, SelectionChangedEventArgs e)
        {
            TabControl tabControl = sender as TabControl;

            TabItem tab = tabControl.SelectedItem as TabItem;

            if (tab != null)
            {
                if (tab.Equals(UserTab))
                {

                }
                else if (tab.Equals(ArtistTab))
                {

                }
                else if (tab.Equals(VenueTab))
                {

                }
                else if (tab.Equals(PerformanceTab))
                {

                }
            }
        }
    }
}
