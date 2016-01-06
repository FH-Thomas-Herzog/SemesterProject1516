/**
 * PerformanceModel.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public class PerformanceModel  extends at.fh.ooe.swk.ufo.webservice.BaseModel  implements java.io.Serializable {
    private long id;

    private java.util.Calendar startDate;

    private java.util.Calendar endDate;

    private boolean moved;

    private java.lang.String venueName;

    private java.lang.String artistName;

    private java.lang.String artistGroupName;

    private java.lang.Long artistId;

    private java.lang.Long artistGroupId;

    private long venueId;

    public PerformanceModel() {
    }

    public PerformanceModel(
           int errorCode,
           java.lang.String error,
           long id,
           java.util.Calendar startDate,
           java.util.Calendar endDate,
           boolean moved,
           java.lang.String venueName,
           java.lang.String artistName,
           java.lang.String artistGroupName,
           java.lang.Long artistId,
           java.lang.Long artistGroupId,
           long venueId) {
        super(
            errorCode,
            error);
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.moved = moved;
        this.venueName = venueName;
        this.artistName = artistName;
        this.artistGroupName = artistGroupName;
        this.artistId = artistId;
        this.artistGroupId = artistGroupId;
        this.venueId = venueId;
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
     * Gets the moved value for this PerformanceModel.
     * 
     * @return moved
     */
    public boolean isMoved() {
        return moved;
    }


    /**
     * Sets the moved value for this PerformanceModel.
     * 
     * @param moved
     */
    public void setMoved(boolean moved) {
        this.moved = moved;
    }


    /**
     * Gets the venueName value for this PerformanceModel.
     * 
     * @return venueName
     */
    public java.lang.String getVenueName() {
        return venueName;
    }


    /**
     * Sets the venueName value for this PerformanceModel.
     * 
     * @param venueName
     */
    public void setVenueName(java.lang.String venueName) {
        this.venueName = venueName;
    }


    /**
     * Gets the artistName value for this PerformanceModel.
     * 
     * @return artistName
     */
    public java.lang.String getArtistName() {
        return artistName;
    }


    /**
     * Sets the artistName value for this PerformanceModel.
     * 
     * @param artistName
     */
    public void setArtistName(java.lang.String artistName) {
        this.artistName = artistName;
    }


    /**
     * Gets the artistGroupName value for this PerformanceModel.
     * 
     * @return artistGroupName
     */
    public java.lang.String getArtistGroupName() {
        return artistGroupName;
    }


    /**
     * Sets the artistGroupName value for this PerformanceModel.
     * 
     * @param artistGroupName
     */
    public void setArtistGroupName(java.lang.String artistGroupName) {
        this.artistGroupName = artistGroupName;
    }


    /**
     * Gets the artistId value for this PerformanceModel.
     * 
     * @return artistId
     */
    public java.lang.Long getArtistId() {
        return artistId;
    }


    /**
     * Sets the artistId value for this PerformanceModel.
     * 
     * @param artistId
     */
    public void setArtistId(java.lang.Long artistId) {
        this.artistId = artistId;
    }


    /**
     * Gets the artistGroupId value for this PerformanceModel.
     * 
     * @return artistGroupId
     */
    public java.lang.Long getArtistGroupId() {
        return artistGroupId;
    }


    /**
     * Sets the artistGroupId value for this PerformanceModel.
     * 
     * @param artistGroupId
     */
    public void setArtistGroupId(java.lang.Long artistGroupId) {
        this.artistGroupId = artistGroupId;
    }


    /**
     * Gets the venueId value for this PerformanceModel.
     * 
     * @return venueId
     */
    public long getVenueId() {
        return venueId;
    }


    /**
     * Sets the venueId value for this PerformanceModel.
     * 
     * @param venueId
     */
    public void setVenueId(long venueId) {
        this.venueId = venueId;
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
            ((this.startDate==null && other.getStartDate()==null) || 
             (this.startDate!=null &&
              this.startDate.equals(other.getStartDate()))) &&
            ((this.endDate==null && other.getEndDate()==null) || 
             (this.endDate!=null &&
              this.endDate.equals(other.getEndDate()))) &&
            this.moved == other.isMoved() &&
            ((this.venueName==null && other.getVenueName()==null) || 
             (this.venueName!=null &&
              this.venueName.equals(other.getVenueName()))) &&
            ((this.artistName==null && other.getArtistName()==null) || 
             (this.artistName!=null &&
              this.artistName.equals(other.getArtistName()))) &&
            ((this.artistGroupName==null && other.getArtistGroupName()==null) || 
             (this.artistGroupName!=null &&
              this.artistGroupName.equals(other.getArtistGroupName()))) &&
            ((this.artistId==null && other.getArtistId()==null) || 
             (this.artistId!=null &&
              this.artistId.equals(other.getArtistId()))) &&
            ((this.artistGroupId==null && other.getArtistGroupId()==null) || 
             (this.artistGroupId!=null &&
              this.artistGroupId.equals(other.getArtistGroupId()))) &&
            this.venueId == other.getVenueId();
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
        if (getStartDate() != null) {
            _hashCode += getStartDate().hashCode();
        }
        if (getEndDate() != null) {
            _hashCode += getEndDate().hashCode();
        }
        _hashCode += (isMoved() ? Boolean.TRUE : Boolean.FALSE).hashCode();
        if (getVenueName() != null) {
            _hashCode += getVenueName().hashCode();
        }
        if (getArtistName() != null) {
            _hashCode += getArtistName().hashCode();
        }
        if (getArtistGroupName() != null) {
            _hashCode += getArtistGroupName().hashCode();
        }
        if (getArtistId() != null) {
            _hashCode += getArtistId().hashCode();
        }
        if (getArtistGroupId() != null) {
            _hashCode += getArtistGroupId().hashCode();
        }
        _hashCode += new Long(getVenueId()).hashCode();
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
        elemField.setFieldName("moved");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Moved"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("venueName");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "VenueName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("artistName");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "ArtistName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("artistGroupName");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "ArtistGroupName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("artistId");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "ArtistId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("artistGroupId");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "ArtistGroupId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("venueId");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "VenueId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
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
