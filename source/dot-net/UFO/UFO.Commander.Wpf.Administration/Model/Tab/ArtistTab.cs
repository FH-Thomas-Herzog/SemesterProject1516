using System.Collections.Generic;
using System.Globalization;
using System.Linq;
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
    public class ArtistTab : BaseTabModel<ArtistModel, ArtistSelectionModel>
    {
        public ArtistTab() : base() { }

        #region DAO, Services
        private IArtistDao artistDao;
        private IArtistGroupDao artistGroupDao;
        private IArtistCategoryDao artistCategoryDao;
        private IArtistService artistService;
        #endregion

        #region TabResources
        private IList<SimpleObjectModel> _ArtistGroups;
        private IList<SimpleObjectModel> _ArtistCategories;
        private IList<SimpleObjectModel> _Countries;
        private string _ImageButtonText;
        public IList<SimpleObjectModel> ArtistGroups
        {
            get { return _ArtistGroups; }
            set
            {
                _ArtistGroups = value;
                FirePropertyChangedEvent();
            }
        }

        public IList<SimpleObjectModel> ArtistCategories
        {
            get { return _ArtistCategories; }
            set
            {
                _ArtistCategories = value;
                FirePropertyChangedEvent();
            }
        }
        public IList<SimpleObjectModel> Countries
        {
            get { return _Countries; }
            set
            {
                _Countries = value;
                FirePropertyChangedEvent();
            }
        }

        public UserContextModel UserContext { get { return (System.Windows.Application.Current as App).UserContext; } }
        public string ImageButtonText { get { return _ImageButtonText; } set { _ImageButtonText = value; FirePropertyChangedEvent(); } }
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
            Artist artist = ViewModel.GetUpdatedEntity();
            try
            {
                artist = artistService.Save(artist);
            }
            catch (ConcurrentUpdateException e)
            {
                artist = new Artist();
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityUpdatedByAnotherUser);
            }
            catch (EntityNotFoundException e)
            {
                artist = new Artist();
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (System.Exception e)
            {
                artist = new Artist();
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon);
            }

            LoadArtists(artist);
            Init(new ArtistModel(artist));
        }

        private void Delete(object data)
        {
            try
            {
                artistService.Delete(ViewModel.Id);
            }
            catch (EntityNotFoundException e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorEntityDoesNotExists);
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorUnknwon);
            }

            LoadArtists();
            Init();
        }
        #endregion

        #region ITabModel
        public override string Header { get { return Resources.ArtistPl; } }
        public override void InitTab(IMessageHandler messageHandler)
        {
            MessageHandler = messageHandler;
            artistDao = DaoFactory.CreateArtistDao();
            artistCategoryDao = DaoFactory.CreateArtistCategoryDao();
            artistGroupDao = DaoFactory.CreateArtistGroupDao();
            artistService = ServiceFactory.CreateArtistService();

            LoadItems();
            LoadArtists();

            Init();

            SaveCommand = new RelayCommand(o => Save(o), o => ViewModel.IsViewModelValid);
            DeleteCommand = new RelayCommand(o => Delete(o), o => ViewModel.IsDeletable);
            NewCommand = new RelayCommand(o => Init(new ArtistModel(new Artist())));
        }

        public override void Init(ArtistModel model = null)
        {
            model = model ?? new ArtistModel(new Artist());
            ArtistSelectionModel selected;
            if (model.Id == null)
            {
                selected = null;
                if (ArtistGroups.Count() > 0)
                {
                    model.ArtistGroup = (ArtistGroup)ArtistGroups.ElementAt(0).Data;
                }
                if (_ArtistCategories.Count() > 0)
                {
                    model.ArtistCategory = (ArtistCategory)ArtistCategories.ElementAt(0).Data;
                }
                model.Entity.CountryCode = new RegionInfo(new CultureInfo(CultureInfo.CurrentCulture.Name, false).LCID).TwoLetterISORegionName;
                model.Entity.CreationUser = UserContext.LoggedUser;
                model.Entity.CreationUserId = UserContext.LoggedUser.Id;
            }
            else
            {
                try
                {
                    selected = new ArtistSelectionModel(model.Entity);
                    model.Entity.CreationUser = UserContext.LoggedUser;
                    model.ArtistGroup = artistGroupDao.Find(model.Entity.ArtistGroupId);
                    model.ArtistCategory = artistCategoryDao.Find(model.Entity.ArtistCategoryId);
                }
                catch (System.Exception e)
                {
                    ViewModel = new ArtistModel(new Artist());
                    selected = null;
                    MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
                }
            }

            model.Entity.ModificationUser = UserContext.LoggedUser;
            model.Entity.ModificationUserId = UserContext.LoggedUser.Id;
            // After preparation fire the PropertyChanged event
            ViewModel = model;
            SelectedSelectionModel = selected;
            ImageButtonText = (!string.IsNullOrWhiteSpace(ViewModel.Image)) ? Resources.ActionRemoveImage : Resources.OpenFileBrowser;
        }

        public override void CleanupTab()
        {
            _ArtistCategories = null;
            _ArtistGroups = null;
            _ViewModel = null;
            SelectionModels.Clear();

            DaoFactory.DisposeDao(artistDao);
            DaoFactory.DisposeDao(artistCategoryDao);
            DaoFactory.DisposeDao(artistGroupDao);
            ServiceFactory.DisposeService(artistService);
        }

        public override void SelectionChanged()
        {
            if (SelectedSelectionModel != null)
            {
                try
                {
                    Artist artist = artistDao.ById((SelectedSelectionModel.Data as Artist).Id);
                    Init(new ArtistModel(artist));
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

        #region Helper
        private void LoadItems()
        {
            try
            {
                ArtistGroups = artistGroupDao.GetAll().Select(d => (new SimpleObjectModel(d, d.Name))).ToList();
                ArtistCategories = artistCategoryDao.GetAll().Select(d => (new SimpleObjectModel(d, d.Name))).ToList();
                Countries = CultureInfo.GetCultures(CultureTypes.SpecificCultures).Select(p => new SimpleObjectModel((new RegionInfo(new CultureInfo(p.Name, false).LCID).TwoLetterISORegionName), (new RegionInfo(new CultureInfo(p.Name, false).LCID).DisplayName))).Distinct().OrderBy(p => p.Label).ToList();
            }
            catch (System.Exception e)
            {
                MessageHandler.ShowErrorMessage(Resources.ErrorDataLoadFailed);
            }
        }

        private void LoadArtists(Artist artist = null)
        {
            SelectionModels.Clear();
            try
            {
                IList<Artist> result = artistDao.FindAllActive();
                foreach (var item in result)
                {
                    ArtistSelectionModel model = new ArtistSelectionModel(item);
                    if (model.Equals(artist))
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
