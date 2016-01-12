package at.fh.ooe.swk.ufo.webservice;

public class SecurityServiceSoapProxy implements at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap {
  private String _endpoint = null;
  private at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap securityServiceSoap = null;
  
  public SecurityServiceSoapProxy() {
    _initSecurityServiceSoapProxy();
  }
  
  public SecurityServiceSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initSecurityServiceSoapProxy();
  }
  
  private void _initSecurityServiceSoapProxy() {
    try {
      securityServiceSoap = (new at.fh.ooe.swk.ufo.webservice.SecurityServiceLocator()).getSecurityServiceSoap();
      if (securityServiceSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)securityServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)securityServiceSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (securityServiceSoap != null)
      ((javax.xml.rpc.Stub)securityServiceSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap getSecurityServiceSoap() {
    if (securityServiceSoap == null)
      _initSecurityServiceSoapProxy();
    return securityServiceSoap;
  }
  
  public at.fh.ooe.swk.ufo.webservice.ResultModelOfNullableOfBoolean validateUserCredentials(java.lang.String username, java.lang.String password) throws java.rmi.RemoteException{
    if (securityServiceSoap == null)
      _initSecurityServiceSoapProxy();
    return securityServiceSoap.validateUserCredentials(username, password);
  }
  
  
}