/**
 * ArtistServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh_ooe.swk.ufo;

public class ArtistServiceLocator extends org.apache.axis.client.Service implements at.fh_ooe.swk.ufo.ArtistService {

    public ArtistServiceLocator() {
    }


    public ArtistServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public ArtistServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for ArtistServiceSoap
    private java.lang.String ArtistServiceSoap_address = "http://localhost:7750/Soap/ArtistService.asmx";

    public java.lang.String getArtistServiceSoapAddress() {
        return ArtistServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ArtistServiceSoapWSDDServiceName = "ArtistServiceSoap";

    public java.lang.String getArtistServiceSoapWSDDServiceName() {
        return ArtistServiceSoapWSDDServiceName;
    }

    public void setArtistServiceSoapWSDDServiceName(java.lang.String name) {
        ArtistServiceSoapWSDDServiceName = name;
    }

    public at.fh_ooe.swk.ufo.ArtistServiceSoap getArtistServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ArtistServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getArtistServiceSoap(endpoint);
    }

    public at.fh_ooe.swk.ufo.ArtistServiceSoap getArtistServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            at.fh_ooe.swk.ufo.ArtistServiceSoapStub _stub = new at.fh_ooe.swk.ufo.ArtistServiceSoapStub(portAddress, this);
            _stub.setPortName(getArtistServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setArtistServiceSoapEndpointAddress(java.lang.String address) {
        ArtistServiceSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (at.fh_ooe.swk.ufo.ArtistServiceSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                at.fh_ooe.swk.ufo.ArtistServiceSoapStub _stub = new at.fh_ooe.swk.ufo.ArtistServiceSoapStub(new java.net.URL(ArtistServiceSoap_address), this);
                _stub.setPortName(getArtistServiceSoapWSDDServiceName());
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
        if ("ArtistServiceSoap".equals(inputPortName)) {
            return getArtistServiceSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("https://ufo.swk.fh-ooe.at/", "ArtistService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("https://ufo.swk.fh-ooe.at/", "ArtistServiceSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("ArtistServiceSoap".equals(portName)) {
            setArtistServiceSoapEndpointAddress(address);
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
