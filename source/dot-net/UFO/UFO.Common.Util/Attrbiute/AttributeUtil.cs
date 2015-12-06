using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace UFO.Common.Util.Attrbiute
{
    public class AttributeUtil
    {
        private AttributeUtil()
        {
        }

        public static IList<T> GetAttributes<T>(Type type) where T : Attribute
        {
            Debug.Assert(type != null, "Cannot get attribute from null type");

            Attribute[] attributes = Attribute.GetCustomAttributes(type);
            return SearchAttributes<T>(attributes);
        }

        public static IList<T> GetAttributes<T>(PropertyInfo property) where T : Attribute
        {
            Debug.Assert(property != null, "Cannot get attribute from null property");

            Attribute[] attributes = Attribute.GetCustomAttributes(property);
            return SearchAttributes<T>(attributes);
        }

        public static IList<PropertyInfo> getPropertyInfos(Type type)
        {
            Debug.Assert(type != null, "Cannot get properies from null type");

            return new List<PropertyInfo>(type.GetProperties());
        }
        public static IList<PropertyInfo> getPropertyInfos<T>(Type type) where T : Attribute
        {
            Debug.Assert(type != null, "Cannot get properies from null type");

            IList<PropertyInfo> foundProperties = new List<PropertyInfo>();
            foreach (var property in getPropertyInfos(type))
            {
                if (Attribute.GetCustomAttributes(property, typeof(T), true).Count() > 0)
                {
                    foundProperties.Add(property);
                }
            }
            return foundProperties;
        }

        #region Private
        private static IList<T> SearchAttributes<T>(Attribute[] attributes) where T : Attribute
        {
            IList<T> foundAttributes = new List<T>();

            foreach (Attribute attr in attributes)
            {
                if (attr is T)
                {
                    foundAttributes.Add((T)attr);
                }
            }
            return foundAttributes;
        }
        #endregion
    }
}
