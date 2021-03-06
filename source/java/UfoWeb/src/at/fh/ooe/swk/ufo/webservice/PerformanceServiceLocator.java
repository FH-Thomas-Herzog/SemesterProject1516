/**
 * PerformanceServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public class PerformanceServiceLocator extends org.apache.axis.client.Service implements at.fh.ooe.swk.ufo.webservice.PerformanceService {

    public PerformanceServiceLocator() {
    }


    public PerformanceServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public PerformanceServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for PerformanceServiceSoap
    private java.lang.String PerformanceServiceSoap_address = "http://localhost:7750/Soap/PerformanceService.asmx";

    public java.lang.String getPerformanceServiceSoapAddress() {
        return PerformanceServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String PerformanceServiceSoapWSDDServiceName = "PerformanceServiceSoap";

    public java.lang.String getPerformanceServiceSoapWSDDServiceName() {
        return PerformanceServiceSoapWSDDServiceName;
    }

    public void setPerformanceServiceSoapWSDDServiceName(java.lang.String name) {
        PerformanceServiceSoapWSDDServiceName = name;
    }

    public at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap getPerformanceServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(PerformanceServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getPerformanceServiceSoap(endpoint);
    }

    public at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap getPerformanceServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoapStub _stub = new at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoapStub(portAddress, this);
            _stub.setPortName(getPerformanceServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setPerformanceServiceSoapEndpointAddress(java.lang.String address) {
        PerformanceServiceSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoapStub _stub = new at.fh.ooe.swk.ufo.webservice.PerformanceServiceSoapStub(new java.net.URL(PerformanceServiceSoap_address), this);
                _stub.setPortName(getPerformanceServiceSoapWSDDServiceName());
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
        if ("PerformanceServiceSoap".equals(inputPortName)) {
            return getPerformanceServiceSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceServiceSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("PerformanceServiceSoap".equals(portName)) {
            setPerformanceServiceSoapEndpointAddress(address);
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
