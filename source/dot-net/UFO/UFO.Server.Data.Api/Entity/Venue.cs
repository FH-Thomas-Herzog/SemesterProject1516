using UFO.Server.Data.Api.Attribute;

namespace UFO.Server.Data.Api.Entity
{
    [Api.Attribute.Entity(TableName = "venue",
                          Schema = "ufo")]
    public class Venue : BaseVersionedEntity<long?, User, long?>
    {
        [Id(PkType = PkType.AUTO)]
        [Column(Name = "id", ReadOnly = true)]
        public override long? Id { get; set; }

        [Column(Name = "name")]
        public string Name { get; set; }

        [Column(Name = "description")]
        public string Description { get; set; }

        [Column(Name = "street")]
        public string Street { get; set; }

        [Column(Name = "zip")]
        public string Zip { get; set; }

        [Column(Name = "city")]
        public string City { get; set; }

        [Column(Name = "country_code")]
        public string CountryCode { get; set; }

        [Column(Name = "gps_coordinate")]
        public string GpsCoordinate { get; set; }
    }
}
