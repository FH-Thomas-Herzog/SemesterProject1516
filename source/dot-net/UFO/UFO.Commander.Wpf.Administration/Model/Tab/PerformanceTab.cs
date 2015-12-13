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
    public class PerformanceTab : BaseTabModel<DayPerformanceModel, SimpleObjectModel>
    {
        #region TabResources
        private IPerformanceDao performanceDao;
        private IArtistDao artistDao;
        private IVenueDao venueDao;
        private IPerformanceService performanceService;
        #endregion

        #region Commands
        private ICommand _SaveCommand;
        private ICommand _DeleteCommand;
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

        private void Save(object data)
        {
            Performance performance = (data as PerformanceModel)?.GetUpdatedEntity();
            try
            {
                performance = performanceService.Save(performance);
                LoadPerformanceDays();
                LoadPerformances(ViewModel?.Date);
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

        private void Delete(object data)
        {
            try
            {
                performanceService.Delete((data as PerformanceModel)?.Id);
                LoadPerformanceDays();
                LoadPerformances();
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

            SaveCommand = new RelayCommand(p => Save(p));
            DeleteCommand = new RelayCommand(p => Delete(p));
        }

        public override void Init(DayPerformanceModel model = null)
        {
            model = model ?? new DayPerformanceModel();
            ViewModel = model;
        }

        public override void CleanupTab()
        {
            SaveCommand = null;
            DeleteCommand = null;
            SelectedSelectionModel = null;
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
                LoadPerformances((SelectedSelectionModel.Data as PerformanceSummaryView).Date);
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

        private void LoadPerformances(DateTime? day = null)
        {
            ViewModel.Performances.Clear();
            if (day != null)
            {
                try
                {
                    IList<SimpleObjectModel> artists = artistDao.FindAllActive().Select(p => new SimpleObjectModel(p, ArtistToSimpleObjectConverter.GetArtistName(p))).OrderBy(p => p.Label).ToList();
                    IList<SimpleObjectModel> venues = venueDao.FindAllActive().Select(p => new SimpleObjectModel(p, p.Name)).OrderBy(p => p.Label).ToList();
                    IList<Performance> items = performanceDao.GetAllPerformancesFullForDay(day.Value);
                    foreach (var item in items)
                    {
                        PerformanceModel model = new PerformanceModel(item);
                        model.Artists = artists;
                        model.Venues = venues;
                        ViewModel.Performances.Add(model);
                    }
                }
                catch (System.Exception)
                {
                    MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
                }
            }
        }
        #endregion
    }
}
