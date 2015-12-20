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

        [ManyToOne(FkProperty = "ArtistId")]
        public Artist Artist { get; set; }

        [ManyToOne(FkProperty = "VenueId")]
        public Venue Venue { get; set; }
    }
}
