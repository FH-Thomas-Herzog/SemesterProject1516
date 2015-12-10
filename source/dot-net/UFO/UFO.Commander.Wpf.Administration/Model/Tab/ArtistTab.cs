using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Wpf.Administration.Converter;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class ArtistTab : BaseTabModel<ArtistModel, ArtistSelectionModel>
    {
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
            Artist artist = artistService.Save(ViewModel.Entity);
            LoadArtists(artist);

            Init(new ArtistModel(artist));
        }

        private void Delete(object data)
        {
            artistService.Delete(ViewModel.Id);
            LoadArtists(); Init();
        }
        #endregion

        #region ITabModel
        public override void InitTab()
        {
            Header = Resources.UserPl;
            artistDao = DaoFactory.CreateArtistDao();
            artistCategoryDao = DaoFactory.CreateArtistCategoryDao();
            artistGroupDao = DaoFactory.CreateArtistGroupDao();
            artistService = ServiceFactory.CreateArtistService();

            LoadItems();
            LoadArtists();

            Init();

            // TODO: Need to handle selection on save and delete properly. Maybe external method called
            SaveCommand = new RelayCommand(o => Save(o), o => ViewModel.IsViewModelValid);
            DeleteCommand = new RelayCommand(o => Delete(o), o => ViewModel.IsDeletable);
            NewCommand = new RelayCommand(o => Init(new ArtistModel(new Artist())));
        }

        public override void Init(ArtistModel model = null)
        {
            ViewModel = model ?? new ArtistModel(new Artist());
            if (ViewModel.Id == null)
            {
                if (ArtistGroups.Count() > 0)
                {
                    ViewModel.ArtistGroup = (ArtistGroup)ArtistGroups.ElementAt(0).Data;
                }
                if (_ArtistCategories.Count() > 0)
                {
                    ViewModel.ArtistCategory = (ArtistCategory)ArtistCategories.ElementAt(0).Data;
                }
                ViewModel.Country = new RegionInfo(new CultureInfo(CultureInfo.CurrentCulture.Name, false).LCID).TwoLetterISORegionName;
            }
        }

        public override void CleanupTab()
        {
            _Header = null;
            _ArtistCategories = null;
            _ArtistGroups = null;
            _ViewModel = null;
            DaoFactory.DisposeDao(artistDao);
            DaoFactory.DisposeDao(artistCategoryDao);
            DaoFactory.DisposeDao(artistGroupDao);
            ServiceFactory.DisposeService(artistService);
        }
        #endregion

        #region Helper
        private void LoadItems()
        {
            ArtistGroups = artistGroupDao.GetAll().Select(d => (new SimpleObjectModel(d, d.Name))).ToList();
            ArtistCategories = artistCategoryDao.GetAll().Select(d => (new SimpleObjectModel(d, d.Name))).ToList();
            Countries = CultureInfo.GetCultures(CultureTypes.SpecificCultures).Select(p => new SimpleObjectModel((new RegionInfo(new CultureInfo(p.Name, false).LCID).TwoLetterISORegionName), (new RegionInfo(new CultureInfo(p.Name, false).LCID).DisplayName))).Distinct().OrderBy(p => p.Label).ToList();
        }

        private void LoadArtists(Artist artist = null)
        {
            SelectionModels = new ObservableCollection<ArtistSelectionModel>();
            IList<Artist> result = artistDao.GetAll();
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
        #endregion
    }
}
