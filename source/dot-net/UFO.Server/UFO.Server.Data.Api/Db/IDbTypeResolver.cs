using System;

namespace UFO.Server.Data.Api.Db
{
    /// <summary>
    /// The interface which defines an db type resolver.
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface IDbTypeResolver<T>
    {
        /// <summary>
        /// Resolves the given type to its db type.
        /// </summary>
        /// <param name="type">the type to eb resolved to the proper DbType</param>
        /// <returns>the db type</returns>
        T resolve(Type type);
    }
}
