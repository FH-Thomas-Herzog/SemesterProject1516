/**
 * SecurityService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public interface SecurityService extends javax.xml.rpc.Service {
    public java.lang.String getSecurityServiceSoapAddress();

    public at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap getSecurityServiceSoap() throws javax.xml.rpc.ServiceException;

    public at.fh.ooe.swk.ufo.webservice.SecurityServiceSoap getSecurityServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
