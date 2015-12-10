using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Service.Api;
using UFO.Commander.Service.Impl.Base;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Service.Impl
{
    public class ArtistService : BaseService, IArtistService
    {
        public ArtistService(DbConnection connection = null) : base(connection)
        {
        }
        public void Delete(long? id)
        {
            throw new NotImplementedException();
        }

        public Artist Save(Artist artist)
        {
            Console.WriteLine("called");
            return null;
        }
    }
}
