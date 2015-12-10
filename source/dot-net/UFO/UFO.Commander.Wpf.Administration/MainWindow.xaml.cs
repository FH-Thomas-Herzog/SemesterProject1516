using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Model.Tab;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public UserContextModel UserContext { get { return (System.Windows.Application.Current as App).UserContext; } }
        public MasterDataTabControler MasterDataTabControler { get; private set; }
        public ObservableCollection<SimpleObjectModel> SelectListItems { get; set; }

        public MainWindow()
        {
            MasterDataTabControler = new MasterDataTabControler();
            MasterDataTabControler.Init();
            SelectListItems = new ObservableCollection<SimpleObjectModel>();
            InitializeComponent();
        }

        private void OnTabChange(object sender, RoutedEventArgs e)
        {
            if ((UserContext.IsLogged) && (!(sender as TabControl).SelectedItem.Equals(MasterDataTabControler.SelectedTabModel)))
            {
                MasterDataTabControler.PreviousSelectedTabModel?.CleanupTab();
                MasterDataTabControler.SelectedTabModel.InitTab();
                e.Handled = true;
            }
        }

        public void InitMainWindow()
        {
            MasterDataTabControler.SetDefaultState();
        }
    }
}
