package model;

import database.dao.ProductDAO;
import service.ProductService;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class Cart implements Serializable {
    private final Map<Integer, CartItem> map = new HashMap<>();
    private int count;
    private double totalPrice;

    public void addProduct(Product p, int quantity) {
        CartItem item = map.containsKey(p.getIdProduct()) ? map.get(p.getIdProduct()) : new CartItem(p);
        item.setQuantity(item.getQuantity() + quantity);
        map.put(p.getIdProduct(), item);
    }

    public void removeProduct(Product p) {
        CartItem item = map.get(p.getIdProduct());
        if (item.getQuantity() == 1) map.remove(p.getIdProduct());
        else item.setQuantity(item.getQuantity() - 1);
    }

    public void deleteProduct(Product p) {
        map.remove(p.getIdProduct());
    }

    public Map<Integer, CartItem> getMap() {
        return map;
    }

    public int getCount() {
        count = 0;
        map.forEach((id, item) -> count += item.getQuantity());
        return count;
    }

    public double getTotalPrice() {
        totalPrice = 0;
        map.forEach((id, item) -> totalPrice += item.getProduct().getNewPrice() * item.getQuantity());
        return totalPrice;
    }

    public void invalidate() {
        final var dao = new ProductDAO();
        map.forEach((id, cartItem) ->
                dao.updateQuantity(id, cartItem.getQuantity() + ProductService.getRemainQuantity(id)));
    }
}
