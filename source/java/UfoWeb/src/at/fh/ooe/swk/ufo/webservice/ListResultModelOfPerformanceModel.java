/**
 * ListResultModelOfPerformanceModel.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package at.fh.ooe.swk.ufo.webservice;

public class ListResultModelOfPerformanceModel  extends at.fh.ooe.swk.ufo.webservice.BaseModel  implements java.io.Serializable {
    private at.fh.ooe.swk.ufo.webservice.PerformanceModel[] result;

    public ListResultModelOfPerformanceModel() {
    }

    public ListResultModelOfPerformanceModel(
           java.lang.Integer errorCode,
           java.lang.Integer serviceErrorCode,
           java.lang.String error,
           at.fh.ooe.swk.ufo.webservice.PerformanceModel[] result) {
        super(
            errorCode,
            serviceErrorCode,
            error);
        this.result = result;
    }


    /**
     * Gets the result value for this ListResultModelOfPerformanceModel.
     * 
     * @return result
     */
    public at.fh.ooe.swk.ufo.webservice.PerformanceModel[] getResult() {
        return result;
    }


    /**
     * Sets the result value for this ListResultModelOfPerformanceModel.
     * 
     * @param result
     */
    public void setResult(at.fh.ooe.swk.ufo.webservice.PerformanceModel[] result) {
        this.result = result;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ListResultModelOfPerformanceModel)) return false;
        ListResultModelOfPerformanceModel other = (ListResultModelOfPerformanceModel) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.result==null && other.getResult()==null) || 
             (this.result!=null &&
              java.util.Arrays.equals(this.result, other.getResult())));
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
        if (getResult() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getResult());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getResult(), i);
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
        new org.apache.axis.description.TypeDesc(ListResultModelOfPerformanceModel.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "ListResultModelOfPerformanceModel"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("result");
        elemField.setXmlName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "Result"));
        elemField.setXmlType(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceModel"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        elemField.setItemQName(new javax.xml.namespace.QName("https://webservice.ufo.swk.ooe.fh.at/", "PerformanceModel"));
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
