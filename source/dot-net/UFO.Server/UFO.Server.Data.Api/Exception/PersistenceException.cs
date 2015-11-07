namespace UFO.Server.Data.Api.Exception
{

    /// <summary>
    /// Own exception for indicating an persistence related exception
    /// </summary>
    public class PersistenceException : System.Exception
    {
        public PersistenceException() { }
        public PersistenceException(string message) : base(message) { }
        public PersistenceException(string message, System.Exception inner) : base(message, inner) { }
        protected PersistenceException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context)
        { }
    }
}
