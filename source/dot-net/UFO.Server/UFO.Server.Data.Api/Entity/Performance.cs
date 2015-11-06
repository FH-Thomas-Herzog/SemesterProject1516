﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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