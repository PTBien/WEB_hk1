package model;

import java.io.Serializable;
import java.util.Date;

public class Account implements Serializable {
    private int id;
    private String username;
    private String password;
    private String status;
    private String email;
    private Date time;

    public Account(int id, String username, String password, String status, String email, Date time) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.status = status;
        this.email = email;
        this.time = time;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
