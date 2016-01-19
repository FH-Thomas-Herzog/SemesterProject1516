/**
 * VenueModel.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public class VenueModel  extends at.fh.ooe.swk.ufo.webservice.BaseModel  implements java.io.Serializable {
    private long id;

    private java.lang.String name;

    private java.lang.String fullAddress;

    private java.lang.String gpsCoordinates;

    private at.fh.ooe.swk.ufo.webservice.PerformanceModel[] performances;

    public VenueModel() {
    }

    public VenueModel(
           java.lang.Integer errorCode,
           java.lang.Integer serviceErrorCode,
           java.lang.String error,
           long id,
           java.lang.String name,
           java.lang.String fullAddress,
           java.lang.String gpsCoordinates,
           at.fh.ooe.swk.ufo.webservice.PerformanceModel[] performances) {
        super(
            errorCode,
            serviceErrorCode,
            error);
        this.id = id;
        this.name = name;
        this.fullAddress = fullAddress;
        this.gpsCoordinates = gpsCoordinates;
        this.performances = performances;
    }


    /**
     * Gets the id value for this VenueModel.
     * 
     * @return id
     */
    public long getId() {
        return id;
    }


    /**
     * Sets the id value for this VenueModel.
     * 
     * @param id
     */
    public void setId(long id) {
        this.id = id;
    }


    /**
     * Gets the name value for this VenueModel.
     * 
     * @return name
     */
    public java.lang.String getName() {
        return name;
    }


    /**
     * Sets the name value for this VenueModel.
     * 
     * @param name
     */
    public void setName(java.lang.String name) {
        this.name = name;
    }


    /**
     * Gets the fullAddress value for this VenueModel.
     * 
     * @return fullAddress
     */
    public java.lang.String getFullAddress() {
        return fullAddress;
    }


    /**
     * Sets the fullAddress value for this VenueModel.
     * 
     * @param fullAddress
     */
    public void setFullAddress(java.lang.String fullAddress) {
        this.fullAddress = fullAddress;
    }


    /**
     * Gets the gpsCoordinates value for this VenueModel.
     * 
     * @return gpsCoordinates
     */
    public java.lang.String getGpsCoordinates() {
        return gpsCoordinates;
    }


    /**
     * Sets the gpsCoordinates value for this VenueModel.
     * 
     * @param gpsCoordinates
     */
    public void setGpsCoordinates(java.lang.String gpsCoordinates) {
        this.gpsCoordinates = gpsCoordinates;
    }


    /**
     * Gets the performances value for this VenueModel.
     * 
     * @return performances
     */
    public at.fh.ooe.swk.ufo.webservice.PerformanceModel[] getPerformances() {
        return performances;
    }


    /**
     * Sets the performances value for this VenueModel.
     * 
     * @param performances
     */
    public void setPerformances(at.fh.ooe.swk.ufo.webservice.PerformanceModel[] performances) {
        this.performances = performances;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof VenueModel)) return false;
        VenueModel other = (VenueModel) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            this.id == other.getId() &&
            ((this.name==null && other.getName()==null) || 
             (this.name!=null &&
              this.name.equals(other.getName()))) &&
            ((this.fullAddress==null && other.getFullAddress()==null) || 
             (this.fullAddress!=null &&
              this.fullAddress.equals(other.getFullAddress()))) &&
            ((this.gpsCoordinates==null && other.getGpsCoordinates()==null) || 
             (this.gpsCoordinates!=null &&
              this.gpsCoordinates.equals(other.getGpsCoordinates()))) &&
            ((this.performances==null && other.getPerformances()==null) || 
             (this.performances!=null &&
              java.util.Arrays.equals(this.performances, other.getPerformances())));
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
        if (getName() != null) {
            _hashCode += getName().hashCode();
        }
        if (getFullAddress() != null) {
            _hashCode += getFullAddress().hashCode();
        }
        if (getGpsCoordinates() != null) {
            _hashCode += getGpsCoordinates().hashCode();
        }
        if (getPerformances() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getPerformances());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getPerformances(), i);
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
        new org.apache.axis.description.TypeDesc(VenueModel.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "VenueModel"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("id");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Id"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("name");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Name"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fullAddress");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "FullAddress"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("gpsCoordinates");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "GpsCoordinates"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("performances");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Performances"));
        elemField.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceServiceRequestModel"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setItemQName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceServiceRequestModel"));
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
