using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Converter
{
    public class ArtistToSimpleObjectConverter : BaseValueToSimpleObjectModelConverter
    {
        public ArtistToSimpleObjectConverter() : base(typeof(Artist)) { }

        public override object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            base.Convert(value, targetType, parameter, culture);
            Artist artist = value as Artist;
            return value == null ? null : new SimpleObjectModel(value, ArtistToSimpleObjectConverter.GetArtistName(artist));
        }

        public static string GetArtistName(Artist artist)
        {
            return artist.Lastname + ", " + artist.Firstname;
        }
    }
}
