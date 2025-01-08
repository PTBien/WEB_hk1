package model;

import java.io.Serializable;

public class TypeProduct implements Serializable {

    private int id_type;
    private String name_type;

    public TypeProduct(int id_type, String name_type) {
        this.id_type = id_type;
        this.name_type = name_type;
    }

    public int getId_type() {
        return id_type;
    }

    public String getName_type() {
        return name_type;
    }

    @Override
    public String toString() {
        return "TypeProduct{" +
                "id_type=" + id_type +
                ", name_type='" + name_type + '\'' +
                '}';
    }
}
