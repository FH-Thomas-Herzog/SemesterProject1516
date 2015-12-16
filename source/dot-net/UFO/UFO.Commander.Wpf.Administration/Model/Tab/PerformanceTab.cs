using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Wpf.Administration.Converter;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Commander.Wpf.Administration.Views.Util;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Entity.View;
using UFO.Server.Data.Api.Exception;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class PerformanceTab : BaseTabModel<PerformanceModel, SimpleObjectModel>
    {
        #region TabResources
        private IPerformanceDao performanceDao;
        private IArtistDao artistDao;
        private IVenueDao venueDao;
        private IPerformanceService performanceService;

        private PerformanceModel _EditViewModel;
        private IList<SimpleObjectModel> _Artists;
        private IList<SimpleObjectModel> _Venues;
        private ObservableCollection<PerformanceModel> _Performances;
        public PerformanceModel EditViewModel
        {
            get { return _EditViewModel; }
            set { _EditViewModel = value; FirePropertyChangedEvent(); }
        }
        public IList<SimpleObjectModel> Artists
        {
            get { return _Artists; }
            set { _Artists = value; FirePropertyChangedEvent(); }
        }
        public IList<SimpleObjectModel> Venues
        {
            get { return _Venues; }
            set { _Venues = value; FirePropertyChangedEvent(); }
        }
        public ObservableCollection<PerformanceModel> Performances
        {
            get { return _Performances; }
            private set { _Performances = value; FirePropertyChangedEvent(); }
        }
        #endregion

        #region Commands
        private ICommand _NewCommand;
        private ICommand _SaveCommand;
        private ICommand _EditCommand;
        private ICommand _DeleteCommand;
        public ICommand NewCommand
        {
            get { return _NewCommand; }
            private set { _NewCommand = value; FirePropertyChangedEvent(); }
        }
        public ICommand SaveCommand
        {
            get { return _SaveCommand; }
            private set { _SaveCommand = value; FirePropertyChangedEvent(); }
        }
        public ICommand EditCommand
        {
            get { return _EditCommand; }
            private set { _EditCommand = value; FirePropertyChangedEvent(); }
        }
        public ICommand DeleteCommand
        {
            get { return _DeleteCommand; }
            private set { _DeleteCommand = value; FirePropertyChangedEvent(); }
        }

        private void Save(object data)
        {
            Performance performance = (data as PerformanceModel)?.GetUpdatedEntity();
            try
            {
                performance = performanceService.Save(performance, 1);
                LoadPerformanceDays();
                LoadPerformances();
            }
            catch (ConcurrentUpdateException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityUpdatedByAnotherUser);
            }
            catch (EntityNotFoundException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon);
            }
        }
        private void Edit(object data)
        {
            try
            {
                Performance performance = performanceDao.ById((long?)data);
                performance.Artist = artistDao.ById(performance.ArtistId);
                performance.Venue = venueDao.ById(performance.VenueId);

                Init(new PerformanceModel(performance));
                return;
            }
            catch (ConcurrentUpdateException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityUpdatedByAnotherUser);
            }
            catch (EntityNotFoundException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon);
            }
            LoadPerformances();
            Init();
        }

        private void Delete(object data)
        {
            try
            {
                performanceService.Delete((data as PerformanceModel)?.Id);
                Performances.Remove(data as PerformanceModel);
            }
            catch (EntityNotFoundException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon);
            }
        }
        public void Move(PerformanceModel model)
        {

        }
        #endregion

        #region ITabModel
        public override string Header { get { return Resources.PerformancePl; } }

        public override void InitTab(IMessageHandler messageHandler)
        {
            if (messageHandler == null)
            {
                throw new ArgumentException("MessageHandler instance must not be null");
            }
            MessageHandler = messageHandler;

            performanceDao = DaoFactory.CreatePerformanceDao();
            artistDao = DaoFactory.CreateArtistDao();
            venueDao = DaoFactory.CreateVenueDao();
            performanceService = ServiceFactory.CreatePerformanceService();

            LoadPerformanceDays();

            Init();

            NewCommand = new RelayCommand(p => Init());
            SaveCommand = new RelayCommand(p => Save(p));
            DeleteCommand = new RelayCommand(p => Delete(p));
            EditCommand = new RelayCommand(p => Edit(p));
        }

        public override void Init(PerformanceModel model = null)
        {
            model = model ?? new PerformanceModel(new Performance());

            Artists = artistDao.FindAllActive().Select(p => new SimpleObjectModel(p, ArtistToSimpleObjectConverter.GetArtistName(p))).OrderBy(p => p.Label).ToList();
            Venues = venueDao.FindAllActive().Select(p => new SimpleObjectModel(p, p.Name)).OrderBy(p => p.Label).ToList();

            if (model.Id == null)
            {
                model.Artist = Artists.Count() > 0 ? (Artists.ElementAt(0).Data as Artist) : null;
                model.Venue = Venues.Count() > 0 ? (Venues.ElementAt(0).Data as Venue) : null;
            }

            ViewModel = model;
        }

        public override void CleanupTab()
        {
            _SaveCommand = null;
            _EditCommand = null;
            _DeleteCommand = null;
            _SelectedSelectionModel = null;
            _Artists = null;
            _Venues = null;
            _Performances = null;
            SelectionModels.Clear();

            DaoFactory.DisposeDao(performanceDao);
            DaoFactory.DisposeDao(artistDao);
            DaoFactory.DisposeDao(venueDao);

            ServiceFactory.DisposeService(performanceService);
        }

        public override void SelectionChanged()
        {
            if (SelectedSelectionModel != null)
            {
                LoadPerformances();
            }
            else
            {
                LoadPerformances();
            }
        }
        #endregion

        #region Helper
        private void LoadPerformanceDays()
        {
            SelectionModels.Clear();
            try
            {
                IList<PerformanceSummaryView> views = performanceDao.GetAllPerformanceSummaryViews();
                foreach (var item in views)
                {
                    SelectionModels.Add(new PerformanceSelectionModel(item));
                }
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
            }
        }

        private void LoadPerformances()
        {
            ObservableCollection<PerformanceModel> performances = new ObservableCollection<PerformanceModel>();
            if (SelectedSelectionModel != null)
            {
                try
                {
                    IList<Performance> items = performanceDao.GetAllPerformancesFullForDay((SelectedSelectionModel.Data as PerformanceSummaryView).Date);
                    foreach (var item in items)
                    {
                        PerformanceModel model = new PerformanceModel(item);
                        performances.Add(model);
                    }
                }
                catch (System.Exception e)
                {
                    MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
                }
            }
            Performances = performances;
        }
        #endregion
    }
}
