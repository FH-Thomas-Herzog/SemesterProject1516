package at.fh.ooe.swk.ufo.webservice;

public class PerformanceServiceSoapProxy implements at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap {
  private String _endpoint = null;
  private at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap performanceServiceSoap = null;
  
  public PerformanceServiceSoapProxy() {
    _initPerformanceServiceSoapProxy();
  }
  
  public PerformanceServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initPerformanceServiceSoapProxy();
  }
  
  private void _initPerformanceServiceSoapProxy() {
    try {
      performanceServiceSoap = (new at.fh.ooe.swk.ufo.webservice.PerformanceServiceLocator()).getPerformanceServiceSoap();
      if (performanceServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)performanceServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)performanceServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (performanceServiceSoap != null)
      ((javax.xml.rpc.Stub)performanceServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap getPerformanceServiceSoap() {
    if (performanceServiceSoap == null)
      _initPerformanceServiceSoapProxy();
    return performanceServiceSoap;
  }
  
  public at.fh.ooe.swk.ufo.webservice.PerformanceModel[] getPerformances(at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest filter) throws java.rmi.RemoteException{
    if (performanceServiceSoap == null)
      _initPerformanceServiceSoapProxy();
    return performanceServiceSoap.getPerformances(filter);
  }
  
  public at.fh.ooe.swk.ufo.webservice.PerformanceModel getDetails(long id) throws java.rmi.RemoteException{
    if (performanceServiceSoap == null)
      _initPerformanceServiceSoapProxy();
    return performanceServiceSoap.getDetails(id);
  }
  
  
}