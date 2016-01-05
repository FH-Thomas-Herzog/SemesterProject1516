package at.fh_ooe.swk.ufo;

public class ArtistServiceSoapProxy implements at.fh_ooe.swk.ufo.ArtistServiceSoap {
  private String _endpoint = null;
  private at.fh_ooe.swk.ufo.ArtistServiceSoap artistServiceSoap = null;
  
  public ArtistServiceSoapProxy() {
    _initArtistServiceSoapProxy();
  }
  
  public ArtistServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initArtistServiceSoapProxy();
  }
  
  private void _initArtistServiceSoapProxy() {
    try {
      artistServiceSoap = (new at.fh_ooe.swk.ufo.ArtistServiceLocator()).getArtistServiceSoap();
      if (artistServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)artistServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)artistServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (artistServiceSoap != null)
      ((javax.xml.rpc.Stub)artistServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public at.fh_ooe.swk.ufo.ArtistServiceSoap getArtistServiceSoap() {
    if (artistServiceSoap == null)
      _initArtistServiceSoapProxy();
    return artistServiceSoap;
  }
  
  public at.fh_ooe.swk.ufo.ArtistModel getDetails(java.math.BigInteger id) throws java.rmi.RemoteException{
    if (artistServiceSoap == null)
      _initArtistServiceSoapProxy();
    return artistServiceSoap.getDetails(id);
  }
  
  
}