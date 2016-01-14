/**
 * PerformanceServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public interface PerformanceServiceSoap extends java.rmi.Remote {
    public at.fh.ooe.swk.ufo.webservice.ListResultModelOfPerformanceModel getPerformances(at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest filter) throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.SingleResultModelOfPerformanceModel save(at.fh.ooe.swk.ufo.webservice.PerformanceRequestModel request) throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.SingleResultModelOfNullableOfBoolean delete(java.lang.String username, java.lang.String password, long id) throws java.rmi.RemoteException;
}
