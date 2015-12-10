using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Commander.Wpf.Administration.Model.Base
{
    public abstract class BaseTabModel<M, S> : BasePropertyChangeModel, ITabedViewModel<M> where M : BasePropertyChangeModel
                                                                                     where S : SimpleObjectModel
    {
        protected string _Header;
        protected M _ViewModel;
        protected S _SelectedSelectionModel;
        protected ObservableCollection<S> _SelectionModels;

        public string Header
        {
            get { return _Header; }
            set
            {
                _Header = value;
                FirePropertyChangedEvent();
            }
        }
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
            }
        }
        public ObservableCollection<S> SelectionModels
        {
            get { return _SelectionModels; }
            set
            {
                _SelectionModels = value;
                FirePropertyChangedEvent();
            }
        }

        public abstract void InitTab();
        public abstract void Init(M model);
        public abstract void CleanupTab();

    }
}
