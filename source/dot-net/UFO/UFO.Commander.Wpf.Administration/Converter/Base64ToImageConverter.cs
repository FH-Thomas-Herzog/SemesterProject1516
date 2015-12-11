using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Media.Imaging;

namespace UFO.Commander.Wpf.Administration.Converter
{
    class Base64ToImageConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value == null)
            {
                return null;
            }

            if (!(value is string))
            {
                throw new ArgumentException("Cannot convert '" + value.GetType().Name + "' to Image");
            }

            try
            {
                string data = value as string;

                MemoryStream stream = new MemoryStream(System.Convert.FromBase64String(data));

                BitmapImage image = new BitmapImage();
                image.BeginInit();
                image.StreamSource = stream;
                image.DecodePixelHeight = 30;
                image.DecodePixelWidth = 30;
                image.EndInit();

                return image;
            }
            catch (System.Exception e)
            {
                // If image is invalid we do not want an error which breaks UI
                return null;
            }
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
