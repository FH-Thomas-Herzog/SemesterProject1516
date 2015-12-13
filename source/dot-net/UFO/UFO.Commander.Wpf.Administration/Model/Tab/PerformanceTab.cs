using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Commander.Wpf.Administration.Views.Util;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Entity.View;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class PerformanceTab : BaseTabModel<PerfromanceModel, SimpleObjectModel>
    {
        #region TabResources
        private IPerformanceDao performanceDao;
        private IArtistDao artistDao;
        private IVenueDao venueDao;
        private IPerformanceService performanceService;
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


        }
        public override void Init(PerfromanceModel model = null)
        {
            model = model ?? new PerfromanceModel();
        }

        public override void CleanupTab()
        {
            DaoFactory.DisposeDao(performanceDao);
            DaoFactory.DisposeDao(artistDao);
            DaoFactory.DisposeDao(venueDao);
            ServiceFactory.DisposeService(performanceService);
        }

        public override void SelectionChanged()
        {
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
                    SelectionModels.Add(new SimpleObjectModel(item, string.Format(item.ToString(), Resources.ArtistPl, Resources.VenuePl, Resources.PerformancePl)));
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
