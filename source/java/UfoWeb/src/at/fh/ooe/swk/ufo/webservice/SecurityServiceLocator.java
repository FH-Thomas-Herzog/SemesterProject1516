/**
 * SecurityServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public class SecurityServiceLocator extends org.apache.axis.client.Service implements at.fh.ooe.swk.ufo.webservice.SecurityService {

    public SecurityServiceLocator() {
    }


    public SecurityServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SecurityServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SecurityServiceSoap
    private java.lang.String SecurityServiceSoap_address = "http://localhost:7750/Soap/SecurityService.asmx";

    public java.lang.String getSecurityServiceSoapAddress() {
        return SecurityServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SecurityServiceSoapWSDDServiceName = "SecurityServiceSoap";

    public java.lang.String getSecurityServiceSoapWSDDServiceName() {
        return SecurityServiceSoapWSDDServiceName;
    }

    public void setSecurityServiceSoapWSDDServiceName(java.lang.String name) {
        SecurityServiceSoapWSDDServiceName = name;
    }

    public at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap getSecurityServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SecurityServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSecurityServiceSoap(endpoint);
    }

    public at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap getSecurityServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            at.fh.ooe.swk.ufo.webservice.SecurityServiceSoapStub _stub = new at.fh.ooe.swk.ufo.webservice.SecurityServiceSoapStub(portAddress, this);
            _stub.setPortName(getSecurityServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSecurityServiceSoapEndpointAddress(java.lang.String address) {
        SecurityServiceSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                at.fh.ooe.swk.ufo.webservice.SecurityServiceSoapStub _stub = new at.fh.ooe.swk.ufo.webservice.SecurityServiceSoapStub(new java.net.URL(SecurityServiceSoap_address), this);
                _stub.setPortName(getSecurityServiceSoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("SecurityServiceSoap".equals(inputPortName)) {
            return getSecurityServiceSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "SecurityService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "SecurityServiceSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SecurityServiceSoap".equals(portName)) {
            setSecurityServiceSoapEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
