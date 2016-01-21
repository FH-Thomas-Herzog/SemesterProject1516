/**
 * PerformanceModel.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public class PerformanceModel  extends at.fh.ooe.swk.ufo.webservice.BaseModel  implements java.io.Serializable {
    private long id;

    private long version;

    private java.util.Calendar startDate;

    private java.util.Calendar endDate;

    private java.util.Calendar formerStartDate;

    private java.util.Calendar formerEndDate;

    private at.fh.ooe.swk.ufo.webservice.ArtistModel artist;

    private at.fh.ooe.swk.ufo.webservice.VenueModel venue;

    private at.fh.ooe.swk.ufo.webservice.VenueModel formerVenue;

    public PerformanceModel() {
    }

    public PerformanceModel(
           java.lang.Integer errorCode,
           java.lang.Integer serviceErrorCode,
           java.lang.String error,
           long id,
           long version,
           java.util.Calendar startDate,
           java.util.Calendar endDate,
           java.util.Calendar formerStartDate,
           java.util.Calendar formerEndDate,
           at.fh.ooe.swk.ufo.webservice.ArtistModel artist,
           at.fh.ooe.swk.ufo.webservice.VenueModel venue,
           at.fh.ooe.swk.ufo.webservice.VenueModel formerVenue) {
        super(
            errorCode,
            serviceErrorCode,
            error);
        this.id = id;
        this.version = version;
        this.startDate = startDate;
        this.endDate = endDate;
        this.formerStartDate = formerStartDate;
        this.formerEndDate = formerEndDate;
        this.artist = artist;
        this.venue = venue;
        this.formerVenue = formerVenue;
    }


    /**
     * Gets the id value for this PerformanceModel.
     * 
     * @return id
     */
    public long getId() {
        return id;
    }


    /**
     * Sets the id value for this PerformanceModel.
     * 
     * @param id
     */
    public void setId(long id) {
        this.id = id;
    }


    /**
     * Gets the version value for this PerformanceModel.
     * 
     * @return version
     */
    public long getVersion() {
        return version;
    }


    /**
     * Sets the version value for this PerformanceModel.
     * 
     * @param version
     */
    public void setVersion(long version) {
        this.version = version;
    }


    /**
     * Gets the startDate value for this PerformanceModel.
     * 
     * @return startDate
     */
    public java.util.Calendar getStartDate() {
        return startDate;
    }


    /**
     * Sets the startDate value for this PerformanceModel.
     * 
     * @param startDate
     */
    public void setStartDate(java.util.Calendar startDate) {
        this.startDate = startDate;
    }


    /**
     * Gets the endDate value for this PerformanceModel.
     * 
     * @return endDate
     */
    public java.util.Calendar getEndDate() {
        return endDate;
    }


    /**
     * Sets the endDate value for this PerformanceModel.
     * 
     * @param endDate
     */
    public void setEndDate(java.util.Calendar endDate) {
        this.endDate = endDate;
    }


    /**
     * Gets the formerStartDate value for this PerformanceModel.
     * 
     * @return formerStartDate
     */
    public java.util.Calendar getFormerStartDate() {
        return formerStartDate;
    }


    /**
     * Sets the formerStartDate value for this PerformanceModel.
     * 
     * @param formerStartDate
     */
    public void setFormerStartDate(java.util.Calendar formerStartDate) {
        this.formerStartDate = formerStartDate;
    }


    /**
     * Gets the formerEndDate value for this PerformanceModel.
     * 
     * @return formerEndDate
     */
    public java.util.Calendar getFormerEndDate() {
        return formerEndDate;
    }


    /**
     * Sets the formerEndDate value for this PerformanceModel.
     * 
     * @param formerEndDate
     */
    public void setFormerEndDate(java.util.Calendar formerEndDate) {
        this.formerEndDate = formerEndDate;
    }


    /**
     * Gets the artist value for this PerformanceModel.
     * 
     * @return artist
     */
    public at.fh.ooe.swk.ufo.webservice.ArtistModel getArtist() {
        return artist;
    }


    /**
     * Sets the artist value for this PerformanceModel.
     * 
     * @param artist
     */
    public void setArtist(at.fh.ooe.swk.ufo.webservice.ArtistModel artist) {
        this.artist = artist;
    }


    /**
     * Gets the venue value for this PerformanceModel.
     * 
     * @return venue
     */
    public at.fh.ooe.swk.ufo.webservice.VenueModel getVenue() {
        return venue;
    }


    /**
     * Sets the venue value for this PerformanceModel.
     * 
     * @param venue
     */
    public void setVenue(at.fh.ooe.swk.ufo.webservice.VenueModel venue) {
        this.venue = venue;
    }


    /**
     * Gets the formerVenue value for this PerformanceModel.
     * 
     * @return formerVenue
     */
    public at.fh.ooe.swk.ufo.webservice.VenueModel getFormerVenue() {
        return formerVenue;
    }


    /**
     * Sets the formerVenue value for this PerformanceModel.
     * 
     * @param formerVenue
     */
    public void setFormerVenue(at.fh.ooe.swk.ufo.webservice.VenueModel formerVenue) {
        this.formerVenue = formerVenue;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof PerformanceModel)) return false;
        PerformanceModel other = (PerformanceModel) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            this.id == other.getId() &&
            this.version == other.getVersion() &&
            ((this.startDate==null && other.getStartDate()==null) || 
             (this.startDate!=null &&
              this.startDate.equals(other.getStartDate()))) &&
            ((this.endDate==null && other.getEndDate()==null) || 
             (this.endDate!=null &&
              this.endDate.equals(other.getEndDate()))) &&
            ((this.formerStartDate==null && other.getFormerStartDate()==null) || 
             (this.formerStartDate!=null &&
              this.formerStartDate.equals(other.getFormerStartDate()))) &&
            ((this.formerEndDate==null && other.getFormerEndDate()==null) || 
             (this.formerEndDate!=null &&
              this.formerEndDate.equals(other.getFormerEndDate()))) &&
            ((this.artist==null && other.getArtist()==null) || 
             (this.artist!=null &&
              this.artist.equals(other.getArtist()))) &&
            ((this.venue==null && other.getVenue()==null) || 
             (this.venue!=null &&
              this.venue.equals(other.getVenue()))) &&
            ((this.formerVenue==null && other.getFormerVenue()==null) || 
             (this.formerVenue!=null &&
              this.formerVenue.equals(other.getFormerVenue())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = super.hashCode();
        _hashCode += new Long(getId()).hashCode();
        _hashCode += new Long(getVersion()).hashCode();
        if (getStartDate() != null) {
            _hashCode += getStartDate().hashCode();
        }
        if (getEndDate() != null) {
            _hashCode += getEndDate().hashCode();
        }
        if (getFormerStartDate() != null) {
            _hashCode += getFormerStartDate().hashCode();
        }
        if (getFormerEndDate() != null) {
            _hashCode += getFormerEndDate().hashCode();
        }
        if (getArtist() != null) {
            _hashCode += getArtist().hashCode();
        }
        if (getVenue() != null) {
            _hashCode += getVenue().hashCode();
        }
        if (getFormerVenue() != null) {
            _hashCode += getFormerVenue().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(PerformanceModel.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceModel"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("id");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Id"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("version");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Version"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("startDate");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "StartDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("endDate");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "EndDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("formerStartDate");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "FormerStartDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("formerEndDate");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "FormerEndDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("artist");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Artist"));
        elemField.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "ArtistModel"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("venue");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Venue"));
        elemField.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "VenueModel"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("formerVenue");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "FormerVenue"));
        elemField.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "VenueModel"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
