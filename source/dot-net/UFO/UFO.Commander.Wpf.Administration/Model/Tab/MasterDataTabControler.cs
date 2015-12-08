using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class MasterDataTabControler : BasePropertyChangeModel
    {
        private ITabModel selectedTabModel;
        private ObservableCollection<ITabModel> tabModels;
        public ObservableCollection<ITabModel> TabModels
        {
            get { return this.tabModels; }
            private set
            {
                this.tabModels = value;
            }
        }
        public ITabModel SelectedTabModel
        {
            get { return this.selectedTabModel; }
            set
            {
                this.selectedTabModel = value; this.selectedTabModel.Init(null); FirePropertyChangedEvent();
            }
        }

        public void Init()
        {
            var userTab = new UserTab();
            userTab.Init(new UserModel());

            ObservableCollection<ITabModel> tabs = new ObservableCollection<ITabModel>();
            tabs.Add(userTab);
            TabModels = tabs;
        }

        public void setDefaultState()
        {
            TabModels.ElementAt(0).ViewModel = new UserModel((System.Windows.Application.Current as App).UserContext.LoggedUser);
        }
    }
}
