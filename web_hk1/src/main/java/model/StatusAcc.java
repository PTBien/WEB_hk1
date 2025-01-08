package model;



import java.io.Serializable;

public class StatusAcc implements Serializable {

    private int id_status;
    private String name_status;

    public int getId_status() {
        return id_status;
    }

    public void setId_status(int id_status) {
        this.id_status = id_status;
    }

    public String getName_status() {
        return name_status;
    }

    public void setName_status(String name_status) {
        this.name_status = name_status;
    }

    public StatusAcc(int id_status, String name_status) {
        this.id_status = id_status;
        this.name_status = name_status;
    }

    @Override
    public String toString() {
        return "StatusAcc{" +
                "id_status=" + id_status +
                ", name_status='" + name_status + '\'' +
                '}'+"\n";
    }
}
