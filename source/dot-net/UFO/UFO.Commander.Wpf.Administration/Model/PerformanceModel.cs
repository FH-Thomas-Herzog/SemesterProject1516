using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Converter;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class PerformanceModel : BaseEntityViewModel<long?, Performance>
    {
        public static readonly int PERFORMANCE_DURATION_HOURS = 1;
        private string _Time;
        private string _ArtistLabel;
        private string _VenueLabel;

        public PerformanceModel(Performance entity) : base(entity)
        {
            DateTime now = DateTime.Now;
            EvaluateTime();
            IsUpdateable = (Entity.Id == null) || (Entity.StartDate.Value.CompareTo(now) > 0);
            IsDeletable = (Entity.Id != null) && (Entity.StartDate.Value.CompareTo(now) > 0);
            if (Entity.Id != null)
            {
                _ArtistLabel = ArtistToSimpleObjectConverter.GetArtistName(Entity.Artist);
                _VenueLabel = Venue.Name;
            }
        }
        public Artist Artist
        {
            get { return Entity.Artist; }
            set { Entity.Artist = value; Entity.ArtistId = value?.Id; FirePropertyChangedEvent(); }
        }
        public Venue Venue
        {
            get { return Entity.Venue; }
            set { Entity.Venue = value; Entity.VenueId = value?.Id; FirePropertyChangedEvent(); }
        }
        public DateTime StartDate
        {
            get { return Entity.StartDate.Value; }
            set
            {
                DateTime tmp = new DateTime(value.Year, value.Month, value.Day, value.Hour, 0, 0);
                Entity.StartDate = value;
                FirePropertyChangedEvent();
                EndDate = Entity.StartDate.Value.AddHours(PERFORMANCE_DURATION_HOURS);
            }
        }
        public DateTime EndDate
        {
            get { return Entity.EndDate.Value; }
            set { Entity.EndDate = value; FirePropertyChangedEvent(); }
        }
        public string Time
        {
            get { return _Time; }
            set { EvaluateTime(); FirePropertyChangedEvent(); }
        }
        public string ArtistLabel
        {
            get { return _ArtistLabel; }
        }
        public string VenueLabel
        {
            get { return Venue.Name; }
        }
        public override Performance GetUpdatedEntity()
        {
            return Entity;
        }

        private void EvaluateTime()
        {
            _Time = Entity.Id == null ? "" : $"{Entity?.StartDate.Value.ToShortTimeString()} - {Entity.EndDate.Value.ToShortTimeString()}";
        }
    }
}
