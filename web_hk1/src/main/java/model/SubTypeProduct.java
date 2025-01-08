package model;

import java.io.Serializable;

public class SubTypeProduct implements Serializable {

    private int id_subtype;
    private String name_type;
    private int id_type_product;
    private String sign;

    public SubTypeProduct(int id_subtype) {
        this.id_subtype = id_subtype;
    }

    public SubTypeProduct(int id_subtype, String name_type) {
        this.id_subtype = id_subtype;
        this.name_type = name_type;
    }

    public SubTypeProduct(int id_subtype, String name_type, int id_type_product, String sign) {
        this.id_subtype = id_subtype;
        this.name_type = name_type;
        this.id_type_product = id_type_product;
        this.sign = sign;
    }

    public int getId_subtype() {
        return id_subtype;
    }

    public void setId_subtype(int id_subtype) {
        this.id_subtype = id_subtype;
    }

    public String getName_type() {
        return name_type;
    }

    public void setName_type(String name_type) {
        this.name_type = name_type;
    }

    public int getId_type_product() {
        return id_type_product;
    }

    public void setId_type_product(int id_type_product) {
        this.id_type_product = id_type_product;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    @Override
    public String toString() {
        return "SubTypeProduct{" +
                "id_subtype=" + id_subtype +
                ", name_type='" + name_type + '\'' +
                ", id_type_product=" + id_type_product +
                ", sign='" + sign + '\'' +
                '}'+"\n";
    }
}
