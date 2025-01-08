package model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Bill implements Serializable {
    private int id;
    private List<Product> products;
    private String status;
    private String customerName;
    private String address;
    private int quantity;
    private double totalPrice;
    private Date timeOrder;

    public Bill() {}

    public Bill(int id, List<Product> products, String status, String address, String customerName, int quantity, double totalPrice, Date timeOrder) {
        this.id = id;
        this.products = products;
        this.status = status;
        this.customerName = customerName;
        this.address = address;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.timeOrder = timeOrder;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getTimeOrder() {
        return timeOrder;
    }

    public void setTimeOrder(Date timeOrder) {
        this.timeOrder = timeOrder;
    }
}
