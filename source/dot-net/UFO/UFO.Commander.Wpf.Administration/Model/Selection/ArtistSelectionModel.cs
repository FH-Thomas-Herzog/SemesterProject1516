using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Selection
{
    public class ArtistSelectionModel : SimpleObjectModel
    {
        public ArtistSelectionModel(Artist artist)
        {
            Data = artist;
            Label = artist.Lastname + ", " + artist.Firstname;
            Image = artist.ImageData;
        }
        public string Image { get; private set;}
    }
}
