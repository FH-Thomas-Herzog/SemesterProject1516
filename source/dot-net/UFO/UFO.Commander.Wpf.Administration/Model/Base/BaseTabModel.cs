using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Commander.Wpf.Administration.Views.Util;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public abstract class BaseTabModel<M, S> : BasePropertyChangeModel, ITabedViewModel<M> where M : BasePropertyChangeModel
                                                                                     where S : SimpleObjectModel
    {
        protected M _ViewModel;
        protected S _SelectedSelectionModel;
        private bool _IsSelectionModelSelected = false;

        public BaseTabModel() : base()
        {
            SelectionModels = new ObservableCollection<S>();
        }

        public abstract string Header { get; }
        public M ViewModel
        {
            get { return _ViewModel; }
            set
            {
                _ViewModel = value;
                // Causes recall of propertyChangeEvent listener of owning TabModel
                FirePropertyChangedEvent();
            }
        }

        public S SelectedSelectionModel
        {
            get { return _SelectedSelectionModel; }
            set
            {
                _SelectedSelectionModel = value;
                FirePropertyChangedEvent();
                IsSelectionModelSelected = (value != null);
            }
        }
        public ObservableCollection<S> SelectionModels
        {
            get; private set;
        }
        public bool IsSelectionModelSelected
        {
            get { return _IsSelectionModelSelected; }
            private set { _IsSelectionModelSelected = value; FirePropertyChangedEvent(); }
        }
        public IMessageHandler MessageHandler { get; set; }

        public abstract void InitTab(IMessageHandler messageHandler);
        public abstract void Init(M model);
        public abstract void CleanupTab();
        public abstract void SelectionChanged();

    }
}
