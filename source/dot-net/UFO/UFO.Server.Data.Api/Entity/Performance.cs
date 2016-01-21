using System;
using UFO.Server.Data.Api.Attribute;

namespace UFO.Server.Data.Api.Entity
{
    [Api.Attribute.Entity(TableName = "performance",
                          Schema = "ufo")]
    public class Performance : BaseVersionedEntity<long?, User, long?>
    {
        [Id(PkType = PkType.AUTO)]
        [Column(Name = "id", ReadOnly = true)]
        public override long? Id { get; set; }

        [Column(Name = "start_date")]
        public DateTime? StartDate { get; set; }

        [Column(Name = "end_date")]
        public DateTime? EndDate { get; set; }

        [Column(Name = "former_start_date")]
        public DateTime? FormerStartDate { get; set; }

        [Column(Name = "former_end_date")]
        public DateTime? FormerEndDate { get; set; }

        [Column(Name = "artist_id")]
        public long? ArtistId { get; set; }

        [Column(Name = "venue_id")]
        public long? VenueId { get; set; }

        [Column(Name = "former_venue_id")]
        public long? FormerVenueId { get; set; }
        
        public Artist Artist { get; set; }
        
        public Venue Venue { get; set; }

        public Venue FormerVenue { get; set; }
    }
}
