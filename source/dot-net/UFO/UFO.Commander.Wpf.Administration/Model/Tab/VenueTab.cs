using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Commander.Wpf.Administration.Views.Util;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Exception;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class VenueTab : BaseTabModel<VenueModel, SimpleObjectModel>
    {
        private IVenueDao venueDao;
        private IVenueService venueService;

        #region TabResources
        public UserContextModel UserContext { get { return (System.Windows.Application.Current as App).UserContext; } }
        #endregion

        #region Commands
        private ICommand _SaveCommand;
        private ICommand _DeleteCommand;
        private ICommand _NewCommand;
        public ICommand SaveCommand
        {
            get { return _SaveCommand; }
            private set { _SaveCommand = value; FirePropertyChangedEvent(); }
        }
        public ICommand DeleteCommand
        {
            get { return _DeleteCommand; }
            private set { _DeleteCommand = value; FirePropertyChangedEvent(); }
        }
        public ICommand NewCommand
        {
            get { return _NewCommand; }
            private set { _NewCommand = value; FirePropertyChangedEvent(); }
        }

        private void Save(object data)
        {
            Venue venue = ViewModel.GetUpdatedEntity();
            try
            {
                venue = venueService.Save(venue);
            }
            catch (ConcurrentUpdateException e)
            {
                venue = new Venue();
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityUpdatedByAnotherUser);
            }
            catch (EntityNotFoundException e)
            {
                venue = new Venue();
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (System.Exception e)
            {
                venue = new Venue();
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon);
            }

            LoadVenues(venue);
            Init(new VenueModel(venue));
        }

        private void Delete(object data)
        {
            try
            {
                venueService.Delete(ViewModel.Id);
            }
            catch (EntityNotFoundException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon);
            }

            LoadVenues();
            Init();
        }
        #endregion

        #region ITabModel
        public override string Header { get { return Resources.VenuePl; } }
        public override void InitTab(IMessageHandler messageHandler)
        {
            if (messageHandler == null)
            {
                throw new ArgumentException("MessageHandler must not be null");
            }
            MessageHandler = messageHandler;

            venueDao = DaoFactory.CreateVenueDao();
            venueService = ServiceFactory.CreateVenueService();

            LoadVenues();
            Init();

            SaveCommand = new RelayCommand(o => Save(o), o => ViewModel.IsViewModelValid);
            DeleteCommand = new RelayCommand(o => Delete(o));
            NewCommand = new RelayCommand(o => Init(new VenueModel(new Venue())));
        }

        public override void Init(VenueModel model = null)
        {
            model = model ?? new VenueModel(new Venue());
            SimpleObjectModel selected = null;

            if (model.Id != null)
            {
                selected = new SimpleObjectModel(model.Entity, model.Name);
                model.IsUpdateable = !venueDao.IsVenueUsed(model.Id);
            }
            else
            {
                model.IsUpdateable = true;
                model.Entity.CreationUser = UserContext.LoggedUser;
                model.Entity.CreationUserId = UserContext.LoggedUser.Id;
            }

            model.IsDeletable = true;
            model.Entity.ModificationUser = UserContext.LoggedUser;
            model.Entity.ModificationUserId = UserContext.LoggedUser.Id;
            // After preparation fire the PropertyChanged event
            ViewModel = model;
            SelectedSelectionModel = selected;
        }

        public override void CleanupTab()
        {
            _SelectedSelectionModel = null;
            _ViewModel = null;
            SelectionModels.Clear();

            DaoFactory.DisposeDao(venueDao);
            ServiceFactory.DisposeService(venueService);
        }


        public override void SelectionChanged()
        {
            if (SelectedSelectionModel != null)
            {
                try
                {
                    Venue venue = venueDao.ById((SelectedSelectionModel.Data as Venue).Id);
                    Init(new VenueModel(venue));
                }
                catch (EntityNotFoundException e)
                {
                    MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
                    Init();
                }
                catch (System.Exception e)
                {
                    MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
                    Init();
                }
            }
            else {
                Init();
            }
        }
        #endregion

        #region Private Helper
        private void LoadVenues(Venue venue = null)
        {
            try
            {
                SelectionModels.Clear();
                IList<Venue> items = venueDao.FindAllActive();
                foreach (var item in items)
                {
                    SimpleObjectModel model = new SimpleObjectModel(item, item.Name);
                    if (model.Data.Equals(venue))
                    {
                        SelectedSelectionModel = model;
                    }
                    SelectionModels.Add(model);
                }
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
            }
        }
        #endregion
    }
}
