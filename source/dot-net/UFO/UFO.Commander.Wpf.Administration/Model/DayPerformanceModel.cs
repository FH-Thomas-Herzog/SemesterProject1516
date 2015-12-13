using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class DayPerformanceModel : BasePropertyChangeModel
    {
        private ObservableCollection<PerformanceModel> _Performances = new ObservableCollection<PerformanceModel>();
        private DateTime _Date = DateTime.Now;
        public ObservableCollection<PerformanceModel> Performances
        {
            get { return _Performances; }
        }

        public DateTime Date
        {
            get { return _Date; }
            set { _Date = value; FirePropertyChangedEvent(); }
        }
    }
}
