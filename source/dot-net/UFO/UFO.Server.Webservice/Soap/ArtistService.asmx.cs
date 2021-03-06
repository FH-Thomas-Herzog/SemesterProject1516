﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Serialization;
using UFO.Server.Data.Api.Dao;
using UFO.Server.Data.Api.Dao.Base;
using UFO.Server.Data.Api.Entity;
using UFO.Server.Data.MySql.Dao;
using UFO.Server.Webservice.Soap.Model;
using UFO.Server.Webservice.Soap.Model.Base;
using UFO.Server.Webservice.Soap.Soap.Authentication;
using UFO.Server.Webservice.Soap.Soap.Base;

namespace UFO.Server.Webservice.Soap
{
    /// <summary>
    /// Summary description for DetailsService
    /// </summary>
    [WebService(Namespace = "https://webservice.ufo.swk.ooe.fh.at/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ArtistService : BaseSecureWebservice
    {

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ListResultModel<ArtistModel> GetSimpleArtists()
        {
            IArtistDao artistDao = DaoFactory.CreateArtistDao();
            ListResultModel<ArtistModel> model;
            if ((model = HandleAuthentication<ListResultModel<ArtistModel>>()) == null)
            {
                model = new ListResultModel<ArtistModel>();
                try
                {
                    IList<Artist> artists = artistDao.FindAllFull();
                    model.Result = artists.Select(artist => new ArtistModel
                    {
                        Id = artist.Id.Value,
                        FirstName = artist.Firstname,
                        LastName = artist.Lastname,
                        Email = artist.Email,
                        CountryCode = artist.CountryCode,
                        ArtistGroup = ((artist.ArtistGroup != null) ? artist.ArtistGroup.Name : ""),
                        ArtistCategory = ((artist.ArtistCategory != null) ? artist.ArtistCategory.Name : "")
                    }).ToList();
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetDetails: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ($"Error during processing the request. exception={e.GetType().Name}");
                }
                finally
                {
                    DaoFactory.DisposeDao(artistDao);
                }
            }

            return model;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public SingleResultModel<ArtistModel> GetDetails(long id)
        {
            IArtistDao artistDao = DaoFactory.CreateArtistDao();
            IArtistGroupDao artistGroupDao = DaoFactory.CreateArtistGroupDao();
            SingleResultModel<ArtistModel> model;
            if ((model = HandleAuthentication<SingleResultModel<ArtistModel>>()) == null)
            {
                model = new SingleResultModel<ArtistModel>();
                try
                {
                    Artist artist = artistDao.ById(id);
                    ArtistGroup group = null;
                    if (artist.ArtistGroupId != null)
                    {
                        group = artistGroupDao.Find(artist.ArtistGroupId);
                    }
                    if ((artist != null) || (artist.Deleted))
                    {
                        model.Result = new ArtistModel
                        {
                            Id = artist.Id.Value,
                            FirstName = artist.Firstname,
                            LastName = artist.Lastname,
                            Email = artist.Email,
                            CountryCode = artist.CountryCode,
                            Url = artist.Url,
                            Image = artist.ImageData,
                            ImageType = artist.ImageFileType,
                            ArtistGroup = ((group != null) ? group.Name : "")
                        };
                    }
                    else {
                        model.ErrorCode = (int)ErrorCode.ENTRY_NOT_FOUND;
                        model.Error = "Artist could not be found for id";
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetDetails: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ($"Error during processing the request. exception={e.GetType().Name}");
                }
                finally
                {
                    DaoFactory.DisposeDao(artistDao);
                    DaoFactory.DisposeDao(artistGroupDao);
                }
            }

            return model;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ListResultModel<NameModel<long>> GetSimpleArtistGroups()
        {
            IArtistGroupDao artistGroupDao = DaoFactory.CreateArtistGroupDao();
            ListResultModel<NameModel<long>> model;
            if ((model = HandleAuthentication<ListResultModel<NameModel<long>>>()) == null)
            {
                model = new ListResultModel<NameModel<long>>();
                try
                {
                    IList<ArtistGroup> groups = artistGroupDao.FindAll();
                    model.Result = groups.Select(item => new NameModel<long>
                    {
                        Id = item.Id.Value,
                        Name = item.Name,
                    }).ToList();
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetSimpleArtistGroups: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ($"Error during processing the request. exception={e.GetType().Name}");
                }
                finally
                {
                    DaoFactory.DisposeDao(artistGroupDao);
                }
            }

            return model;
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = false)]
        [SoapHeader("credentials")]
        public ListResultModel<NameModel<long>> GetSimpleArtistCategories()
        {
            IArtistCategoryDao artistCategoryDao = DaoFactory.CreateArtistCategoryDao();
            ListResultModel<NameModel<long>> model;
            if ((model = HandleAuthentication<ListResultModel<NameModel<long>>>()) == null)
            {
                model = new ListResultModel<NameModel<long>>();
                try
                {
                    IList<ArtistCategory> categories = artistCategoryDao.FindAll();
                    model.Result = categories.Select(item => new NameModel<long>
                    {
                        Id = item.Id.Value,
                        Name = item.Name,
                    }).ToList();
                }
                catch (Exception e)
                {
                    Console.WriteLine("GetSimpleArtistCategories: Error during processing. error: " + e.Message);
                    model.ErrorCode = (int)ErrorCode.UNKNOWN_ERROR;
                    model.Error = ($"Error during processing the request. exception={e.GetType().Name}");
                }
                finally
                {
                    DaoFactory.DisposeDao(artistCategoryDao);
                }
            }

            return model;
        }
    }
}
