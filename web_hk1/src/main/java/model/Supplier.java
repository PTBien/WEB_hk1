package model;

import java.io.Serializable;

public class Supplier implements Serializable {

    private int id_supplier;
    private String name_supplier;

    public Supplier(int id_supplier, String name_supplier) {
        this.id_supplier = id_supplier;
        this.name_supplier = name_supplier;
    }

    public int getId_supplier() {
        return id_supplier;
    }

    public String getName_supplier() {
        return name_supplier;
    }

    @Override
    public String toString() {
        return "Supplier{" +
                "id_supplier=" + id_supplier +
                ", name_supplier='" + name_supplier + '\'' +
                '}';
    }
}
