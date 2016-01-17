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
using UFO.Commander.Wpf.Administration.Model;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Commander.Wpf.Administration.Model.Tab;
using UFO.Commander.Wpf.Administration.Views.Util;
using Xceed.Wpf.Toolkit;

namespace UFO.Commander.Wpf.Administration.Views.Performance
{
    /// <summary>
    /// Interaction logic for PerformaceMasterData.xaml
    /// </summary>
    public partial class PerformaceMasterData : UserControl
    {
        public PerformaceMasterData()
        {
            InitializeComponent();
        }

        private void OnNotifyButtonClick(object sender, RoutedEventArgs e)
        {
            PerformanceNotification control = new PerformanceNotification(); ;
            control.DataContext = new PerformanceNotificationModel(new MessageHandler());
            Window window = new Window
            {
                Title = Administration.Properties.Resources.Email,
                Content = control,
                Height = (control.Height +50),
                Width = (control.Width + 30),
                Margin = new Thickness(5.0),
                ResizeMode = ResizeMode.NoResize
            };            

            window.ShowDialog();
        }
    }
}
