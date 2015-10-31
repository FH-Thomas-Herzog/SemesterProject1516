using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Test.Data.MySql.Util
{
    public class UserEntityProvider : IEntityInstanceProvider<long?, User>
    {

        User GetValidEntity(int iterationCount)
        {
            User user = new User();
            user.FirstName = "Hugo";
            user.LastName = "Masterhood";
            user.Username = "cchet_" + iterationCount;
            user.Email = "cchet_" + iterationCount + "@masterhood.at";
            user.CreationUserId = null;
            user.ModificationUserId = null;

            return user;
        }

        User GetInvalidEntity(int iterationCount)
        {
            User user = new User();
            user.FirstName = "Hugo";
            user.LastName = "Masterhood";
            user.Username = "cchet_" + iterationCount;
            user.Email = "cchet_" + iterationCount + "@masterhood.at";
            user.CreationUserId = null;
            user.ModificationUserId = null;
        }
    }
}
