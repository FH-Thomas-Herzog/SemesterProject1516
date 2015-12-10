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
    public class ArtistGroupToSimpleObjectModelConverter : BaseValueToSimpleObjectModelConverter
    {
        public ArtistGroupToSimpleObjectModelConverter() : base(typeof(ArtistGroup)) { }

        public override object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            base.Convert(value, targetType, parameter, culture);
            return value == null ? null : new SimpleObjectModel(value, ((ArtistGroup)value)?.Name);
        }
    }
}
