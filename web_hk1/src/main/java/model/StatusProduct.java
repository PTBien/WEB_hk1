package model;

import java.io.Serializable;

public class StatusProduct implements Serializable {

    private int id_status;
    private String name_status;

    public StatusProduct(int id_status, String name_status) {
        this.id_status = id_status;
        this.name_status = name_status;
    }

    public int getId_status() {
        return id_status;
    }

    public String getName_status() {
        return name_status;
    }

    @Override
    public String toString() {
        return "StatusProduct{" +
                "id_status=" + id_status +
                ", name_status='" + name_status + '\'' +
                '}';
    }
}
