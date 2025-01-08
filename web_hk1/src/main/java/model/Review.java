package model;

import java.io.Serializable;

public class Review implements Serializable {
    private int id;
    private int productId;
    private String fullName;
    private String phone;
    private String email;
    private String content;
    private int stars;

    public Review() {}

    public Review(int id, int productId, String fullName, String phone, String email, String content, int stars) {
        this.id = id;
        this.productId = productId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.content = content;
        this.stars = stars;
    }

    public Review(int productId, String fullName, String phone, String email, String content, int stars) {
        this.productId = productId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.content = content;
        this.stars = stars;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getStars() {
        return stars;
    }

    public void setStars(int stars) {
        this.stars = stars;
    }
}
