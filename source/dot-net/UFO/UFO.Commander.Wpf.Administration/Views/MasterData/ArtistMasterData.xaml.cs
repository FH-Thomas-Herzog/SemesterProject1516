using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
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
using UFO.Commander.Wpf.Administration.Exception;
using UFO.Commander.Wpf.Administration.Model.Tab;

namespace UFO.Commander.Wpf.Administration.Views.MasterData
{
    /// <summary>
    /// Interaction logic for ArtistMasterData.xaml
    /// </summary>
    public partial class ArtistMasterData : UserControl
    {
        private static readonly long MAX_BASE_64_STRING_LENGTH = 10240;
        private ArtistTab Tab { get { return DataContext as ArtistTab; } }

        public ArtistMasterData()
        {
            InitializeComponent();
        }

        private void OnImageButtonClick(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(Tab.ViewModel.Image))
            {
                Tab.ViewModel.Image = null;
                Tab.ViewModel.ImageFileType = null;
                Tab.ImageButtonText = Properties.Resources.OpenFileBrowser;
            }
            else {
                OpenFileDialog openFileDialog = new OpenFileDialog();
                openFileDialog.Filter = Properties.Resources.Image + " |*.png;*.jpeg;*.jpg";
                openFileDialog.Multiselect = false;
                openFileDialog.ShowDialog();
                if (!string.IsNullOrWhiteSpace(openFileDialog.FileName))
                {
                    string base64 = Convert.ToBase64String(File.ReadAllBytes(openFileDialog.FileName));
                    if (base64.Length > MAX_BASE_64_STRING_LENGTH)
                    {
                        throw new ViewException(string.Format(Properties.Resources.ErrorImageToLarge), true, null);
                    }
                    Tab.ViewModel.Image = base64;
                    Tab.ViewModel.ImageFileType = System.IO.Path.GetExtension(openFileDialog.FileName);
                    Tab.ImageButtonText = Properties.Resources.ActionRemoveImage;
                }
            }
        }
    }
}
