using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Api.Base;
using UFO.Commander.Wpf.Administration.Converter;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Views.MasterData
{
    /// <summary>
    /// Interaction logic for UserMasterData.xaml
    /// </summary>
    public partial class UserMasterData : UserControl
    {
        public UserModel UserModel { get; private set; }
        public IList<SimpleObjectModel> UserTypes { get; set; }
        public App Application { get { return System.Windows.Application.Current as App; } }
        private IUserService userService;

        public UserMasterData()
        {
            InitializeComponent();
        }

        public override void BeginInit()
        {
            base.BeginInit();
            LoadUserTypes();
        }

        private void LoadUserTypes()
        {
            IList<SimpleObjectModel> userTypeItems = new List<SimpleObjectModel>();
            foreach (User.UserType item in Enum.GetValues(typeof(User.UserType)))
            {
                userTypeItems.Add(new SimpleObjectModel(item, UserTypeToSimpleObjectModelConverter.UserTypeToString(item)));
            }
            UserTypes = userTypeItems;
            UserTypes.OrderBy(model => model.Label);
        }

        private void OnVisibilityChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            UserControl control = sender as UserControl;

            switch (control.Visibility)
            {
                case Visibility.Visible:
                    UserModel = new UserModel(Application.UserContext.LoggedUser);
                    string test = UserModel.Firstname;
                    userService = ServiceFactory.CreateUserService();
                    break;
                case Visibility.Hidden:
                    UserModel = null;
                    ServiceFactory.DisposeService(userService);
                    break;
                default: break;
            }
        }
    }
}
