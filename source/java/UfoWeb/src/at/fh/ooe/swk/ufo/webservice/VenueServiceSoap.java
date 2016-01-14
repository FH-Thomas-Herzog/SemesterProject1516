/**
 * VenueServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public interface VenueServiceSoap extends java.rmi.Remote {
    public at.fh.ooe.swk.ufo.webservice.ListResultModelOfVenueModel getVenues() throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.ListResultModelOfVenueModel getVenuesForPerformances(at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest filter) throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.ListResultModelOfVenueModel getVenueForPerformances(long id, at.fh.ooe.swk.ufo.webservice.PerformanceFilterRequest filter) throws java.rmi.RemoteException;
}
