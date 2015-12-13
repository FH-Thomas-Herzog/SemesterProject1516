using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Views.Util;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class MasterDataTabControler : BasePropertyChangeModel
    {
        private int _SelectedTabIdx = -1;
        private ITabModel _SelectedTabModel;
        private ObservableCollection<ITabModel> tabModels = new ObservableCollection<ITabModel>();
        public UserContextModel UserContext { get { return (System.Windows.Application.Current as App).UserContext; } }
        public ObservableCollection<ITabModel> TabModels
        {
            get { return this.tabModels; }
            private set
            {
                this.tabModels = value;
            }
        }
        public int SelectedTabIdx
        {
            get { return this._SelectedTabIdx; }
            set
            {
                _SelectedTabIdx = value;
                FirePropertyChangedEvent();
            }
        }
        public ITabModel PreviousSelectedTab { get; set; }
        public ITabModel SelectedTabModel
        {
            get { return _SelectedTabModel; }
            set
            {
                _SelectedTabModel = value;
                FirePropertyChangedEvent();
            }
        }
        public ITabModel PreviousSelectedTabModel { get; set; }
        public void Init()
        {
            TabModels.Clear();

            var artistTab = new ArtistTab();
            var venueTab = new VenueTab();
            var performanceTab = new PerformanceTab();

            TabModels.Add(artistTab);
            TabModels.Add(venueTab);
            TabModels.Add(performanceTab);
        }

        public void SetDefaultState(IMessageHandler messageHandler)
        {
            int idx = 0;
            ITabModel model = TabModels.ElementAt(idx);
            model.InitTab(messageHandler);
            SelectedTabModel = model;
        }
    }
}
