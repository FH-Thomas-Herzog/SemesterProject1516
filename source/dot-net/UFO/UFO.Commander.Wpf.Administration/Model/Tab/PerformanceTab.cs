using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Resources;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Service.Api.Exception;
using UFO.Commander.Wpf.Administration.Converter;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Commander.Wpf.Administration.Views.Util;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.Api.Entity.View;
using UFO.Server.Data.Api.Exception;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class PerformanceTab : BaseTabModel<PerformanceModel, SimpleObjectModel>
    {
        private static ResourceManager serviceResource = new ResourceManager(typeof(Commander.Service.Api.Properties.Resource));

        #region TabResources
        private IPerformanceDao performanceDao;
        private IArtistDao artistDao;
        private IVenueDao venueDao;
        private IPerformanceService performanceService;
        private DateTime _MinimumStartDate;

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
        public DateTime MinimumStartDate
        {
            get { return _MinimumStartDate; }
            set { _MinimumStartDate = value; FirePropertyChangedEvent(); }
        }

        public UserContextModel UserContext { get { return (System.Windows.Application.Current as App).UserContext; } }
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
            Performance performance = ViewModel.GetUpdatedEntity();
            bool isNew = performance.Id == null;
            try
            {
                performance = performanceService.Save(performance, 1);
                performance.Artist = artistDao.ById(performance.ArtistId);
                performance.Venue = venueDao.ById(performance.VenueId);
                PerformanceModel model = new PerformanceModel(performance);
                if (!isNew)
                {
                    Performances[Performances.IndexOf(model)] = model;
                }
                else
                {
                    Performances.Add(model);
                    Init(model);
                }
                PerformanceSummaryView view = (SelectedSelectionModel.Data as PerformanceSummaryView);
                if (!view.Date.Date.Equals(performance.StartDate.Value.Date))
                {
                    LoadPerformanceDays(performance.StartDate.Value.Date);
                    Init();
                }
                return;
            }
            catch (ConcurrentUpdateException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityUpdatedByAnotherUser);
                LoadPerformances();
            }
            catch (EntityNotFoundException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
                LoadPerformances();
            }
            catch (ServiceException e)
            {
                MessageHandler.ShowErrorMessage(GetErrorMessageForPerformanceErrorcdeo(e.ErrorCode));
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon + $" (errorMessage={e.Message})");
                LoadPerformances();
            }
            Init();
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
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon + $" (errorMessage={e.Message})");
            }
            LoadPerformances();
            Init();
        }

        private void Delete(object data)
        {
            try
            {
                PerformanceModel model = (data as PerformanceModel) ?? ViewModel;
                performanceService.Delete(model.Id);
                Performances.Remove(model);
                if (Performances.Count() == 0)
                {
                    LoadPerformanceDays();
                }
            }
            catch (EntityNotFoundException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (ServiceException e)
            {
                if (e.ErrorCode != null)
                {
                    MessageHandler.ShowErrorMessage(GetErrorMessageForPerformanceErrorcdeo(e.ErrorCode));
                }
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon + $" (errorMessage={e.Message})");
            }

            Init();
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
            Performances = new ObservableCollection<PerformanceModel>(); ;

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

            DateTime now = DateTime.Now;
            DateTime minimumStartDate = new DateTime(now.Year, now.Month, now.Day, now.Hour, 0, 0);
            minimumStartDate.AddHours(1);

            if (model.Id == null)
            {
                model.Artist = Artists.Count() > 0 ? (Artists.ElementAt(0).Data as Artist) : null;
                model.Venue = Venues.Count() > 0 ? (Venues.ElementAt(0).Data as Venue) : null;
                minimumStartDate = new DateTime(now.Year, now.Month, now.Day, now.Hour, 0, 0);

                model.StartDate = minimumStartDate;
                model.EndDate = model.StartDate.AddHours(PerformanceModel.PERFORMANCE_DURATION_HOURS);
                model.Entity.CreationUserId = UserContext.LoggedUser.Id;
            }

            model.Entity.ModificationUserId = UserContext.LoggedUser.Id;
            ViewModel = model;
            MinimumStartDate = minimumStartDate;
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
        private void LoadPerformanceDays(DateTime? dateTime = null)
        {
            SelectionModels.Clear();
            try
            {
                IList<PerformanceSummaryView> views = performanceDao.GetAllPerformanceSummaryViews();
                foreach (var item in views)
                {
                    PerformanceSelectionModel model = new PerformanceSelectionModel(item);
                    SelectionModels.Add(model);
                    // Auto select proper model
                    if ((dateTime != null) && (item.Date.Date.Equals(dateTime.Value.Date)))
                    {
                        SelectedSelectionModel = model;
                    }
                }
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
            }
        }

        private void LoadPerformances()
        {
            Performances.Clear();
            //ObservableCollection<PerformanceModel> performances = new ObservableCollection<PerformanceModel>();
            if (SelectedSelectionModel != null)
            {
                try
                {
                    IList<Performance> items = performanceDao.GetAllPerformancesFullForDay((SelectedSelectionModel.Data as PerformanceSummaryView).Date);
                    foreach (var item in items)
                    {
                        PerformanceModel model = new PerformanceModel(item);
                        Performances.Add(model);
                    }
                }
                catch (System.Exception e)
                {
                    MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
                }
            }
            //Performances= performances;
            if (Performances.Count() == 0)
            {
                SelectedSelectionModel = null;
            }
        }

        private String GetErrorMessageForPerformanceErrorcdeo(int? code)
        {
            if ((code != null) && (Enum.IsDefined(typeof(PerformanceErrorCode), code)))
            {
                DictionaryEntry entry = serviceResource.GetResourceSet(System.Threading.Thread.CurrentThread.CurrentUICulture, true, true).OfType<DictionaryEntry>().FirstOrDefault(de => de.Key.ToString() == (Enum.GetName(typeof(PerformanceErrorCode), code)));
                return (entry.Value != null) ? (entry.Value.ToString()) : (Resources.ErrorUnknwon + " (code=" + code + ")");
            }

            return (Resources.ErrorUnknwon + " (code=" + code + ")");
        }
        #endregion
    }
}
