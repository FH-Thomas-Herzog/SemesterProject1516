/**
 * SecurityServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public interface SecurityServiceSoap extends java.rmi.Remote {
    public at.fh.ooe.swk.ufo.webservice.SingleResultModelOfNullableOfBoolean validateUserCredentials(java.lang.String username, java.lang.String password) throws java.rmi.RemoteException;
}
