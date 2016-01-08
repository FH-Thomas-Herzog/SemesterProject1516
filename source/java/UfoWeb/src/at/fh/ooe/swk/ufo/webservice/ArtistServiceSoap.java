/**
 * ArtistServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public interface ArtistServiceSoap extends java.rmi.Remote {
    public at.fh.ooe.swk.ufo.webservice.ArtistModel[] getSimpleArtists() throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.ArtistModel getDetails(long id) throws java.rmi.RemoteException;
}
