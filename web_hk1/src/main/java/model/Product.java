

package model;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable {
    private int idProduct;
    private String imgPath;
    private String name;

    private ProductReview review;

    private String status;
    private String desc;
    private int quantity;
    private String type;
    private String subtype;
    private String supply;
    private int sold;
    private Date date;
    private int views;
    private double oldPrice;
    private double newPrice;

    private int listed_price;
    private int current_price;
    private int type_product;
    private int status_product;
    private int supplier;


    private SubTypeProduct subTypeP;

    private StatusProduct statusP;


    public Product() {
    }

    public Product(int idProduct, String imgPath, String name, int quantity, int listed_price, int current_price, SubTypeProduct subTypeP, StatusProduct statusP) {
        this.idProduct = idProduct;
        this.imgPath = imgPath;
        this.name = name;
        this.quantity = quantity;
        this.listed_price = listed_price;
        this.current_price = current_price;

        this.subTypeP = subTypeP;
        this.statusP = statusP;
    }

    public Product(String imgPath, String name, String desc, int quantity, int listed_price, int current_price, int type_product, int status_product, int supplier) {
        this.imgPath = imgPath;
        this.name = name;
        this.desc = desc;
        this.quantity = quantity;
        this.listed_price = listed_price;
        this.current_price = current_price;
        this.type_product = type_product;
        this.status_product = status_product;
        this.supplier = supplier;
    }

    public Product(int idProduct, String name, int quantity, int listed_price, int current_price, int type_product, int status_product) {
        this.idProduct = idProduct;
        this.name = name;
        this.quantity = quantity;
        this.listed_price = listed_price;
        this.current_price = current_price;
        this.type_product = type_product;
        this.status_product = status_product;
    }

    public Product(int idProduct, String imgPath, String name, ProductReview review,
                   String status, String desc, int quantity, String type, String subtype,
                   String supply, int sold, Date date, int views, double oldPrice, double newPrice) {
        this.idProduct = idProduct;
        this.imgPath = imgPath;
        this.name = name;
        this.review = review;
        this.status = status;
        this.desc = desc;
        this.quantity = quantity;
        this.type = type;
        this.subtype = subtype;
        this.supply = supply;
        this.sold = sold;
        this.date = date;
        this.views = views;
        this.oldPrice = oldPrice;
        this.newPrice = newPrice;
    }

    // Getters and Setters

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ProductReview getReview() {
        return review;
    }

    public void setReview(ProductReview review) {
        this.review = review;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSubtype() {
        return subtype;
    }

    public void setSubtype(String subtype) {
        this.subtype = subtype;
    }

    public String getSupply() {
        return supply;
    }

    public void setSupply(String supply) {
        this.supply = supply;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public double getOldPrice() {
        return oldPrice;
    }

    public void setOldPrice(double oldPrice) {
        this.oldPrice = oldPrice;
    }

    public double getNewPrice() {
        return newPrice;
    }

    public void setNewPrice(double newPrice) {
        this.newPrice = newPrice;
    }

    public int getListed_price() {
        return listed_price;
    }

    public int getCurrent_price() {
        return current_price;
    }

    public int getType_product() {
        return type_product;
    }

    public int getStatus_product() {
        return status_product;
    }

    public int getSupplier() {
        return supplier;
    }


    public SubTypeProduct getSubTypeP() {
        return subTypeP;
    }

    public StatusProduct getStatusP() {
        return statusP;
    }


    public void setListed_price(int listed_price) {
        this.listed_price = listed_price;
    }

    public void setCurrent_price(int current_price) {
        this.current_price = current_price;
    }

    public void setType_product(int type_product) {
        this.type_product = type_product;
    }

    public void setStatus_product(int status_product) {
        this.status_product = status_product;
    }

    public void setSupplier(int supplier) {
        this.supplier = supplier;
    }

    @Override
    public String toString() {
        return "Product{" +
                "idProduct=" + idProduct +
                ", imgPath='" + imgPath + '\'' +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", listed_price=" + listed_price +
                ", current_price=" + current_price +
                ", subTypeP=" + subTypeP +
                ", statusP=" + statusP +
                '}' + "\n";
    }
}
