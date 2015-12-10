using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Resources;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Data;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Commander.Wpf.Administration.Model.Selection;
using UFO.Commander.Wpf.Administration.Properties;

namespace UFO.Commander.Wpf.Administration.Converter
{
    public abstract class BaseValueToSimpleObjectModelConverter : IValueConverter
    {
        private Type ValueType { get; set; }

        protected BaseValueToSimpleObjectModelConverter(Type expectedType)
        {
            if(expectedType == null)
            {
                throw new ArgumentException("Expected type must not be null");
            }
            ValueType = expectedType;
        }

        public virtual object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if(value == null)
            {
                return null;
            }
            CheckForValidType(value.GetType());
            return null;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return ((SimpleObjectModel)value)?.Data;
        }

        protected void CheckForValidType(Type currentType)
        {
            if (!ValueType.Equals(currentType))
            {
                throw new ArgumentException("Value has not a proper type: " + ValueType.Name);
            }
        }

    }
}
