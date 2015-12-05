using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UFO.Commander.Wpf.Administration.Model;
using UFO.Server.Data.Api.Entity;

namespace UFO.Commander.Test.Wpf.Administration
{
    class Program
    {
        static void Main(string[] args)
        {
            ArtistGroup group = new ArtistGroup();
            group.Name = "MyGroup";
            group.Description = "blabla";
            ArtistCategory category = new ArtistCategory();
            category.Name = "MyCategory";
            category.Description = "blabla";

            Artist artist = new Artist();
            artist.Firstname = "Thoams";
            artist.Lastname = "Herzog";
            artist.Email = "thomas.herzhog@gmail.com";
            artist.CountryCode = "de_DE";
            artist.Deleted = false;
            artist.ArtistCategoryId = -1;
            artist.ArtistGroupId = -1;
            artist.ArtistCategory = category;
            artist.ArtistGroup = group;
            ArtistModel model = new ArtistModel(artist);
            Console.WriteLine("Firstname: " + model.Firstname);
            Console.WriteLine("Lastname: " + model.Lastname);
            Console.WriteLine("ArtistGroup: " + model.ArtistGroup.Name);
            Console.WriteLine("ArtistCategory: " + model.ArtistCategory.Name);

            model.Firstname = "New Fristname";
            model.Lastname = "New Lastname";
            category.Name = "New Category name";
            group.Name = "New Group name";
            model.ArtistCategory = category;
            model.ArtistGroup = group;

            Console.WriteLine("Firstname: " + model.Entity.Firstname);
            Console.WriteLine("Lastname: " + model.Entity.Lastname);
            Console.WriteLine("ArtistGroup: " + model.Entity.ArtistGroup.Name);
            Console.WriteLine("ArtistCategory: " + model.Entity.ArtistCategory.Name);

            Console.Read();
        }
    }
}
