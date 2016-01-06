/**
 * PerformanceServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public interface PerformanceServiceSoap extends java.rmi.Remote {
    public at.fh.ooe.swk.ufo.webservice.PerformanceModel[] getPerformances(at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest filter) throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.PerformanceModel getDetails(long id) throws java.rmi.RemoteException;
}
