package at.fh.ooe.swk.ufo.webservice;

public class ArtistServiceSoapProxy implements at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap {
  private String _endpoint = null;
  private at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap artistServiceSoap = null;
  
  public ArtistServiceSoapProxy() {
    _initArtistServiceSoapProxy();
  }
  
  public ArtistServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initArtistServiceSoapProxy();
  }
  
  private void _initArtistServiceSoapProxy() {
    try {
      artistServiceSoap = (new at.fh.ooe.swk.ufo.webservice.ArtistServiceLocator()).getArtistServiceSoap();
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
  
  public at.fh.ooe.swk.ufo.webservice.ArtistServiceSoap getArtistServiceSoap() {
    if (artistServiceSoap == null)
      _initArtistServiceSoapProxy();
    return artistServiceSoap;
  }
  
  public at.fh.ooe.swk.ufo.webservice.ArtistModel getDetails(long id) throws java.rmi.RemoteException{
    if (artistServiceSoap == null)
      _initArtistServiceSoapProxy();
    return artistServiceSoap.getDetails(id);
  }
  
  public at.fh.ooe.swk.ufo.webservice.ArtistModel[] getSimpleArtists() throws java.rmi.RemoteException{
    if (artistServiceSoap == null)
      _initArtistServiceSoapProxy();
    return artistServiceSoap.getSimpleArtists();
  }
  
  
}