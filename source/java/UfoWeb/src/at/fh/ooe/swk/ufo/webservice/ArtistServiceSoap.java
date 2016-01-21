/**
 * ArtistServiceSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public interface ArtistServiceSoap extends java.rmi.Remote {
    public at.fh.ooe.swk.ufo.webservice.ListResultModelOfArtistModel getSimpleArtists() throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.SingleResultModelOfArtistModel getDetails(long id) throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.ListResultModelOfNameModelOfInt64 getSimpleArtistGroups() throws java.rmi.RemoteException;
    public at.fh.ooe.swk.ufo.webservice.ListResultModelOfNameModelOfInt64 getSimpleArtistCategories() throws java.rmi.RemoteException;
}
