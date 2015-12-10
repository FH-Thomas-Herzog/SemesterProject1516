using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class ArtistSelectionModel : SimpleObjectModel
    {
        public ArtistSelectionModel(Artist artist)
        {
            Data = artist;
            Label = artist.Lastname + ", " + artist.Firstname;
        }
        public string Image { get; set; }
    }
}
