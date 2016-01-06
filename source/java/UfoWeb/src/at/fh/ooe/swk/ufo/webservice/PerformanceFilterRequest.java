/**
 * PerformanceFilterRequest.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public class PerformanceFilterRequest  implements java.io.Serializable {
    private java.util.Calendar startDate;

    private java.util.Calendar endDate;

    private java.lang.Long[] artistIds;

    private java.lang.Long[] venueIds;

    public PerformanceFilterRequest() {
    }

    public PerformanceFilterRequest(
           java.util.Calendar startDate,
           java.util.Calendar endDate,
           java.lang.Long[] artistIds,
           java.lang.Long[] venueIds) {
           this.startDate = startDate;
           this.endDate = endDate;
           this.artistIds = artistIds;
           this.venueIds = venueIds;
    }


    /**
     * Gets the startDate value for this PerformanceFilterRequest.
     * 
     * @return startDate
     */
    public java.util.Calendar getStartDate() {
        return startDate;
    }


    /**
     * Sets the startDate value for this PerformanceFilterRequest.
     * 
     * @param startDate
     */
    public void setStartDate(java.util.Calendar startDate) {
        this.startDate = startDate;
    }


    /**
     * Gets the endDate value for this PerformanceFilterRequest.
     * 
     * @return endDate
     */
    public java.util.Calendar getEndDate() {
        return endDate;
    }


    /**
     * Sets the endDate value for this PerformanceFilterRequest.
     * 
     * @param endDate
     */
    public void setEndDate(java.util.Calendar endDate) {
        this.endDate = endDate;
    }


    /**
     * Gets the artistIds value for this PerformanceFilterRequest.
     * 
     * @return artistIds
     */
    public java.lang.Long[] getArtistIds() {
        return artistIds;
    }


    /**
     * Sets the artistIds value for this PerformanceFilterRequest.
     * 
     * @param artistIds
     */
    public void setArtistIds(java.lang.Long[] artistIds) {
        this.artistIds = artistIds;
    }

    public java.lang.Long getArtistIds(int i) {
        return this.artistIds[i];
    }

    public void setArtistIds(int i, java.lang.Long _value) {
        this.artistIds[i] = _value;
    }


    /**
     * Gets the venueIds value for this PerformanceFilterRequest.
     * 
     * @return venueIds
     */
    public java.lang.Long[] getVenueIds() {
        return venueIds;
    }


    /**
     * Sets the venueIds value for this PerformanceFilterRequest.
     * 
     * @param venueIds
     */
    public void setVenueIds(java.lang.Long[] venueIds) {
        this.venueIds = venueIds;
    }

    public java.lang.Long getVenueIds(int i) {
        return this.venueIds[i];
    }

    public void setVenueIds(int i, java.lang.Long _value) {
        this.venueIds[i] = _value;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof PerformanceFilterRequest)) return false;
        PerformanceFilterRequest other = (PerformanceFilterRequest) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.startDate==null && other.getStartDate()==null) || 
             (this.startDate!=null &&
              this.startDate.equals(other.getStartDate()))) &&
            ((this.endDate==null && other.getEndDate()==null) || 
             (this.endDate!=null &&
              this.endDate.equals(other.getEndDate()))) &&
            ((this.artistIds==null && other.getArtistIds()==null) || 
             (this.artistIds!=null &&
              java.util.Arrays.equals(this.artistIds, other.getArtistIds()))) &&
            ((this.venueIds==null && other.getVenueIds()==null) || 
             (this.venueIds!=null &&
              java.util.Arrays.equals(this.venueIds, other.getVenueIds())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getStartDate() != null) {
            _hashCode += getStartDate().hashCode();
        }
        if (getEndDate() != null) {
            _hashCode += getEndDate().hashCode();
        }
        if (getArtistIds() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getArtistIds());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getArtistIds(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getVenueIds() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getVenueIds());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getVenueIds(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(PerformanceFilterRequest.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceFilterRequest"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
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
        elemField.setFieldName("artistIds");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "ArtistIds"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("venueIds");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "VenueIds"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
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
