package model;

import java.io.Serializable;

public class Admin implements Serializable {
    private String username;
    private String passAD;
    private int id_role_admin;
    private int id_status_acc;

    private String name_role_admin;

    private String name_status_acc;
    private String fullname;

    public Admin(String username, String passAD) {
        this.username = username;
        this.passAD = passAD;
    }

    public Admin(String username, String passAD, int id_role_admin, int id_status_acc, String fullname) {
        this.username = username;
        this.passAD = passAD;
        this.id_role_admin = id_role_admin;
        this.id_status_acc = id_status_acc;
        this.fullname = fullname;
    }

    public Admin(String username, String passAD, int id_role_admin, int id_status_acc, String name_role_admin, String name_status_acc, String fullname) {
        this.username = username;
        this.passAD = passAD;
        this.id_role_admin = id_role_admin;
        this.id_status_acc = id_status_acc;
        this.name_role_admin = name_role_admin;
        this.name_status_acc = name_status_acc;
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public String getPassAD() {
        return passAD;
    }

    public int getId_role_admin() {
        return id_role_admin;
    }

    public int getId_status_acc() {
        return id_status_acc;
    }

    public String getName_role_admin() {
        return name_role_admin;
    }

    public String getName_status_acc() { return name_status_acc; }

    public String getFullname() {
        return fullname;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassAD(String passAD) {
        this.passAD = passAD;
    }

    public void setId_role_admin(int id_role_admin) {
        this.id_role_admin = id_role_admin;
    }

    public void setId_status_acc(int id_status_acc) {
        this.id_status_acc = id_status_acc;
    }

    public void setName_role_admin(String name_role_admin) {
        this.name_role_admin = name_role_admin;
    }
    public void setName_status_acc(String name_status_acc) {
        this.name_status_acc = name_status_acc;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "username='" + username + '\'' +
                ", passAD='" + passAD + '\'' +
                ", id_role_admin=" + id_role_admin +
                ", id_status_acc=" + id_status_acc +
                ", name_role_admin='" + name_role_admin + '\'' +
                ", name_status_acc='" + name_status_acc + '\'' +
                ", fullname='" + fullname + '\'' +
                '}'+"\n";
    }
}
