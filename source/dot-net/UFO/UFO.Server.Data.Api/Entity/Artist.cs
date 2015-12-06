using System;
using UFO.Server.Data.Api.Attribute;

namespace UFO.Server.Data.Api.Entity
{
    [Api.Attribute.Entity(TableName = "artist",
                          Schema = "ufo")]
    public class Artist : BaseVersionedEntity<long?, User, long?>
    {
        [Id(PkType = PkType.AUTO)]
        [Column(Name = "id", ReadOnly = true)]
        public override long? Id { get; set; }

        [Column(Name = "firstname")]
        public string Firstname { get; set; }

        [Column(Name = "lastname")]
        public string Lastname { get; set; }

        [Column(Name = "email")]
        public string Email { get; set; }

        [Column(Name = "country_code")]
        public string CountryCode { get; set; }

        [Column(Name = "artist_group_id")]
        public long? ArtistGroupId { get; set; }

        [Column(Name = "artist_category_id")]
        public long? ArtistCategoryId { get; set; }

        [Column(Name = "deleted_flag")]
        public bool Deleted { get; set; }

        [Column(Name = "image")]
        public string ImageData { get; set; }

        [Column(Name = "image_file_type")]
        public string ImageFileType { get; set; }

        [ManyToOne(FkProperty = "ArtCategoryId")]
        public ArtistCategory ArtistCategory { get; set; }

        [ManyToOne(FkProperty = "ArtistGroupId")]
        public ArtistGroup ArtistGroup { get; set; }
    }
}
