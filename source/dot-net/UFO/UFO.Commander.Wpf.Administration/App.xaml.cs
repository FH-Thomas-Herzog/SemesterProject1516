using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        // There can only be one user context at the time per application
        private static UserContextModel userContext = new UserContextModel();
        public UserContextModel UserContext { get { return App.userContext; } }
        public IList<string> Countries { get; set; }

        private void Application_Startup(object sender, StartupEventArgs e)
        {
            LoadCountries();
        }

        /// <summary>
        /// Loads the countries.
        /// </summary>
        private void LoadCountries()
        {
            IList<string> countries = new List<string>();

            foreach (CultureInfo cul in CultureInfo.GetCultures(CultureTypes.SpecificCultures))
            {
                RegionInfo country = new RegionInfo(new CultureInfo(cul.Name, false).LCID);
                countries.Add(country.DisplayName.ToString());
            }

            countries.OrderBy(name => name).Distinct();
        }
    }


}
