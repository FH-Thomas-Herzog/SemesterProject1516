﻿using System;
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
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Converter
{
    public class UserTypeToSimpleObjectModelConverter : BaseValueToSimpleObjectModelConverter
    {
        public UserTypeToSimpleObjectModelConverter() : base(typeof(User.UserType)) { }

        public override object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            base.Convert(value, targetType, parameter, culture);
            return value == null ? null : new SimpleObjectModel(value, UserTypeToSimpleObjectModelConverter.UserTypeToString((User.UserType)value));
        }

        public static string UserTypeToString(User.UserType? type)
        {
            if (type != null)
            {
                switch (type)
                {
                    case User.UserType.ADMINISTRATOR:
                        return Resources.Administrator;
                    case User.UserType.ARTIST:
                        return Resources.Artist;
                    case User.UserType.EXTERNAL:
                        return Resources.ExternalUser;
                    default:
                        throw new ArgumentException("UserType not managed. UserType: " + Enum.GetName(typeof(User.UserType), type));
                }
            }
            return "";
        }
    }
}
