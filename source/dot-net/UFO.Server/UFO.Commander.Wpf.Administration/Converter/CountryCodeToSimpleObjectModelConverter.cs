using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Resources;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Converter
{
    public class CountryCodeToSimpleObjectModelConverter : BaseValueToSimpleObjectModelConverter
    {
        public CountryCodeToSimpleObjectModelConverter() : base(typeof(string)) { }

        public override object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            object converted = base.Convert(value, targetType, parameter, culture);
            return converted ?? new SimpleObjectModel(value, new RegionInfo((string)value).DisplayName);
        }
    }
}
