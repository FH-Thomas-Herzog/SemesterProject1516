using UFO.Server.Data.Api.Entity;

namespace UFO.Server.Data.Api.Dao
{
    public interface IUserDao : IDao<long?, User>
    {
        User GetAdminUserForUsername(string username);
    }
}
