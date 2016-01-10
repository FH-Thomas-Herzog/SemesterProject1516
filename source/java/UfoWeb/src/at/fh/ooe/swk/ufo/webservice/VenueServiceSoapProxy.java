package at.fh.ooe.swk.ufo.webservice;

public class VenueServiceSoapProxy implements at.fh.ooe.swk.ufo.webservice.VenueServiceSoap {
  private String _endpoint = null;
  private at.fh.ooe.swk.ufo.webservice.VenueServiceSoap venueServiceSoap = null;
  
  public VenueServiceSoapProxy() {
    _initVenueServiceSoapProxy();
  }
  
  public VenueServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initVenueServiceSoapProxy();
  }
  
  private void _initVenueServiceSoapProxy() {
    try {
      venueServiceSoap = (new at.fh.ooe.swk.ufo.webservice.VenueServiceLocator()).getVenueServiceSoap();
      if (venueServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)venueServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)venueServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (venueServiceSoap != null)
      ((javax.xml.rpc.Stub)venueServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public at.fh.ooe.swk.ufo.webservice.VenueServiceSoap getVenueServiceSoap() {
    if (venueServiceSoap == null)
      _initVenueServiceSoapProxy();
    return venueServiceSoap;
  }
  
  public at.fh.ooe.swk.ufo.webservice.VenueModel[] getVenues() throws java.rmi.RemoteException{
    if (venueServiceSoap == null)
      _initVenueServiceSoapProxy();
    return venueServiceSoap.getVenues();
  }
  
  public at.fh.ooe.swk.ufo.webservice.VenueModel[] getVenueForPerformances(long id, at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest filter) throws java.rmi.RemoteException{
    if (venueServiceSoap == null)
      _initVenueServiceSoapProxy();
    return venueServiceSoap.getVenueForPerformances(id, filter);
  }
  
  public at.fh.ooe.swk.ufo.webservice.VenueModel[] getVenuesForPerformances(at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest filter) throws java.rmi.RemoteException{
    if (venueServiceSoap == null)
      _initVenueServiceSoapProxy();
    return venueServiceSoap.getVenuesForPerformances(filter);
  }
  
  
}