using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Converter;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model.Tab
{
    public class UserTab : BaseTabModel<UserModel>
    {
        public IList<SimpleObjectModel> UserTypes { get; set; }

        public override void Init(BasePropertyChangeModel model)
        {
            LoadUserTypes();
            ViewModel = model ?? new UserModel(new User());
            Header = Resources.UserPl;
        }

        public override void Destroy()
        {
            UserTypes = null;
            ViewModel = null;
            Header = null;
        }

        #region Actions
        #endregion

        #region Helper
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
        #endregion
    }
}
