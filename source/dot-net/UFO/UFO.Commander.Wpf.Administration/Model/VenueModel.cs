using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model.Base;
using UFO.Commander.Wpf.Administration.Properties;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Wpf.Administration.Model
{
    public class VenueModel : BaseVersionedEntityViewModel<long?, Venue>
    {
        public VenueModel(Venue entity) : base(entity)
        {
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Name
        {
            get { return Entity.Name; }
            set { Entity.Name = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Street
        {
            get { return Entity.Street; }
            set { Entity.Street = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string Zip
        {
            get { return Entity.Zip; }
            set { Entity.Zip = value; FirePropertyChangedEvent(); }
        }

        [Required(ErrorMessageResourceName = "ErrorRequired",
                  ErrorMessageResourceType = typeof(Resources))]
        [StringLength(100,
                      MinimumLength = 1,
                      ErrorMessageResourceName = "ErrorInvalidStringLength",
                      ErrorMessageResourceType = typeof(Resources))]
        public string City
        {
            get { return Entity.City; }
            set { Entity.City = value; FirePropertyChangedEvent(); }
        }

        public string GpsCoordinate
        {
            get { return Entity.GpsCoordinate; }
            set { Entity.GpsCoordinate = value; FirePropertyChangedEvent(); }
        }

        public override Venue GetUpdatedEntity()
        {
            return Entity;
        }
    }
}
