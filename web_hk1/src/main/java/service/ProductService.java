package service;


import database.DbConnection;
import database.dao.ProductDAO;
import model.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public final class ProductService {
    private static final String QUERY_PRODUCTS =
            "SELECT p.id_product, url_img_product, name_product, description_product, quantity_product, " +
                    "date_inserted, name_status_product, name_type_product, name_subtype, " +
                    "name_supplier, views, pp.current_price, pp.listed_price " +
                    "FROM products p JOIN price_product pp ON p.id_product = pp.id_product " +
                    "JOIN status_product sp ON p.id_status_product = sp.id_status_product " +
                    "JOIN subtype_product st ON p.id_subtype = st.id_subtype " +
                    "JOIN suppliers s ON p.id_supplier = s.id_supplier " +
                    "JOIN type_product tp ON st.id_type_product = tp.id_type_product\t";

    public static List<Product> queryProducts(String query, Object... params) {
        try (var ps = DbConnection.getInstance().getPreparedStatement(query)) {
            for (int i = 0; i < params.length; i++)
                ps.setObject(i + 1, params[i]);
            return getProducts(ps.executeQuery());
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }

    private static int queryInt(String query, Object... params) {
        try (var ps = DbConnection.getInstance().getPreparedStatement(query)) {
            for (int i = 0; i < params.length; i++)
                ps.setObject(i + 1, params[i]);
            var rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            return -1;
        }
    }

    public static List<Product> getProducts() {
        return queryProducts(QUERY_PRODUCTS);
    }

    public static Product getProductById(int id) {
        return queryProducts(QUERY_PRODUCTS + "WHERE p.id_product=?", id).get(0);
    }

    public static List<Product> getProductsByType(int type) {
        return queryProducts(QUERY_PRODUCTS + "WHERE tp.id_type_product=?", type);
    }

    public static List<Product> getProductsBySubtype(int subtypeId) {
        return queryProducts(QUERY_PRODUCTS + "WHERE st.id_subtype=?", subtypeId);
    }

    public static List<Product> getNewProducts(int day) {
        return queryProducts(QUERY_PRODUCTS +
                "WHERE DATE(date_inserted) > (NOW() - INTERVAL ? DAY) ORDER BY DATE(date_inserted) DESC", day);
    }

    public static List<Product> getSellingProducts(int day) {
        return queryProducts(QUERY_PRODUCTS + "WHERE p.id_product IN (" +
                "SELECT id_product FROM bills b JOIN bill_detail bd ON b.id_bill = bd.id_bill " +
                "WHERE DATE(time_order) > (NOW() - INTERVAL ? DAY) " +
                "GROUP BY id_product ORDER BY SUM(quantity) DESC)", day);
    }

    // return best-selling product of all time
    public static List<Product> getBestSellingProducts() {
        return queryProducts(QUERY_PRODUCTS + "WHERE p.id_product IN (" +
                "SELECT id_product FROM bills b JOIN bill_detail bd ON b.id_bill = bd.id_bill " +
                "GROUP BY id_product ORDER BY SUM(quantity) DESC)");
    }

    public static List<Product> getTodayDiscountProducts() {
        return queryProducts(QUERY_PRODUCTS + "WHERE p.id_product IN (" +
                "SELECT p.id_product FROM products p JOIN price_product pp on p.id_product = pp.id_product " +
                "WHERE DATE(date) = DATE(NOW()))");
    }

    public static List<Product> getProhibitedProducts() {
        return queryProducts(QUERY_PRODUCTS + "WHERE sp.id_status_product = ?", 3);
    }

    public static List<Product> getOutOfStockProducts() {
        return queryProducts(QUERY_PRODUCTS + "WHERE quantity_product = ?", 0);
    }

    public static List<Product> searchProductsByName(String name) {
        return queryProducts(QUERY_PRODUCTS + "WHERE LOWER(name_product) LIKE LOWER(CONCAT('%',?,'%'))", name);
    }

    // return products added in month ?
    public static List<Product> getAddedProductIn(int month) {
        return queryProducts(QUERY_PRODUCTS +
                "WHERE MONTH(date_inserted) = ? AND YEAR(date_inserted) = YEAR(CURRENT_DATE)", month);
    }

    public static List<Product> getProductsByBillId(int id) {
        return queryProducts(QUERY_PRODUCTS +
                "JOIN bill_detail b ON b.id_product = p.id_product WHERE id_bill = ?", id);
    }

    public static int getTotalSold() {
        return queryInt("SELECT SUM(quantity) FROM bill_detail");
    }

    public static int getTotalSoldIn(int month) {
        return queryInt("SELECT SUM(quantity) FROM bills b JOIN bill_detail bd ON b.id_bill = bd.id_bill " +
                "WHERE MONTH(time_order) = ? AND YEAR(time_order) = YEAR(CURRENT_DATE)", month);
    }

    public static int getTotalSoldOf(int productId) {
        return queryInt(
                "SELECT SUM(quantity) FROM bill_detail WHERE id_product = ? GROUP BY id_product", productId);
    }

    public static int getRemainQuantity(int productId) {
        return queryInt("SELECT quantity_product FROM products WHERE id_product = ?", productId);
    }

    public static int getProductsHasQuantity(int quantity) {
        return queryInt("SELECT COUNT(*) FROM products WHERE quantity_product <= ?", quantity);
    }

    public static int getTypeBySubtypeId(int subtypeId) {
        return queryInt("SELECT id_type_product FROM subtype_product WHERE id_subtype = ?", subtypeId);
    }

    public static Map<Integer, String> getSubtypesByType(int type) {
        return queryMap("SELECT id_subtype, name_subtype FROM subtype_product WHERE id_type_product=?", type);
    }

    public static Map<Integer, String> getTypes() {
        return queryMap("SELECT id_type_product, name_type_product FROM type_product");
    }

    public static Map<Integer, String> getSuppliers() {
        return queryMap("SELECT id_supplier, name_supplier FROM suppliers");
    }

    private static List<Product> getProducts(ResultSet rs) {
        List<Product> products = new ArrayList<>();
        try {
            while (rs.next()) {
                int productId = rs.getInt("id_product");
                String name = rs.getString("name_product");
                String desc = rs.getString("description_product");
                String imgPath = rs.getString("url_img_product");
                ProductReview review = getReviewByProductId(productId);
                String status = rs.getString("name_status_product");
                int quantity = rs.getInt("quantity_product");
                double oldPrice = rs.getInt("listed_price");
                double newPrice = rs.getInt("current_price");
                String type = rs.getString("name_type_product");
                String subtype = rs.getString("name_subtype");
                String supply = rs.getString("name_supplier");
                int sold = getTotalSoldOf(productId);
                Date date = rs.getDate("date_inserted");
                int views = rs.getInt("views");
                products.add(new Product(productId, imgPath, name, review, status, desc, quantity, type, subtype,
                        supply, sold, date, views, oldPrice, newPrice));
            }
            return products;
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }

    public static String getTypeName(int typeId) {
        try (var ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT name_type_product FROM type_product WHERE id_type_product=?")) {
            ps.setInt(1, typeId);
            var rs = ps.executeQuery();
            rs.next();
            return rs.getString("name_type_product");
        } catch (SQLException e) {
            return null;
        }
    }

    public static ProductReview getReviewByProductId(int id) {
        try (var ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT COUNT(*) FROM review_product WHERE id_product=? AND stars=?")) {
            int[] stars = new int[5];
            for (int i = 0; i < 5; i++) {
                ps.setInt(1, id);
                ps.setInt(2, i + 1);
                var rs = ps.executeQuery();
                while (rs.next()) stars[i] = rs.getInt(1);
            }
            return new ProductReview(id, stars[4], stars[3], stars[2], stars[1], stars[0], Arrays.stream(stars).sum());
        } catch (SQLException e) {
            return null;
        }
    }
    public static boolean addNewProduct(Product p, Admin admin) {
        /*
        b1: thêm tên,mô tả,hình ảnh,số lượng,mã loại,mã trạng thái,mã nhà cung cấp, tên admin vào bảng products

        b2: lấy id của sản phẩm vừa được thêm vào bảng products dựa trên tên,mô tả,hình ảnh,số lượng,mã loại,mã trạng thái,mã nhà cung cấp

        b3: thêm giá niêm yết và giá bán thực tế của sản phẩm vào bảng price_product dựa trên id
         */

        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        boolean checkInsertProduct = dao.insertProduct(connectDB, p, admin.getUsername()); // b1
        if (checkInsertProduct) {

            int idProduct = dao.getIdProduct(connectDB, p); // b2
            p.setIdProduct(idProduct);
            @SuppressWarnings("unused")
            boolean checkInsertPrice = dao.insertPriceProduct(connectDB, p, admin.getUsername()); //b3

            // do nothing
            return true;

        }
        connectDB.close();
        return false;
    }

    public static boolean deleteProductById(int id) {

        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        try {
            connectDB.getConn().setAutoCommit(false);
            boolean checkDelete1 = dao.deleteProductByIdOnTable_price_product(connectDB, id);
            boolean checkDelete2 = dao.deleteProductByIdOnTable_sold_product(connectDB, id);
            boolean checkDelete3 = dao.deleteProductByIdOnTable_review_product(connectDB, id);
            boolean checkDelete4 = dao.deleteProductByIdOnTable_products(connectDB, id);
            if (checkDelete1 && checkDelete2 && checkDelete3 && checkDelete4) {
                connectDB.getConn().commit();                           // kết thúc giao tác
                return true;
            }
        } catch (SQLException e) {
            try {
                System.out.println("DeleteProduct rollback: " + id);
                connectDB.getConn().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            try {
                connectDB.getConn().setAutoCommit(true);
                connectDB.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static boolean updateProductById(Product p, Admin admin) {
        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        try {
            connectDB.getConn().setAutoCommit(false);
            boolean update1 = dao.AdminUpdateProductOnTable_products(connectDB, p, admin.getUsername());
            boolean update2 = dao.AdminInsertPriceProductOnTable_price_product(connectDB, p, admin.getUsername());
            if (update1 && update2) {
                connectDB.getConn().commit();                    // kết thúc giao tác
                return true;
            }
        } catch (SQLException e) {
            try {
                System.out.println("rollback");
                connectDB.getConn().rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        } finally {
            try {
                connectDB.getConn().setAutoCommit(true);
                connectDB.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }


    @SuppressWarnings("unchecked")
    private static <K, V> Map<K, V> queryMap(String query, Object... params) {
        Map<K, V> map = new HashMap<>();
        try (var ps = DbConnection.getInstance().getPreparedStatement(query)) {
            for (int i = 0; i < params.length; i++)
                ps.setObject(i + 1, params[i]);
            var rs = ps.executeQuery();
            while (rs.next()) {
                K k = (K) rs.getObject(1);
                V v = (V) rs.getObject(2);
                map.put(k, v);
            }
            return map;
        } catch (SQLException e) {
            return new HashMap<>();
        }
    }



    ////////////////////////////

    public static List<Product> getAllProducts() {
        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        try {
            return dao.getAllProducts(connectDB);
        } finally {
            connectDB.close();
        }

    }

    public static List<Object> getSubTypeAndStatusAndSupplierForProduct() {
        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        List<Object> result = new ArrayList<>();

        List<SubTypeProduct> subtypeProducts = dao.getSubTypeProducts(connectDB);
        List<StatusProduct> statusProducts = dao.getStatusProducts(connectDB);
        List<Supplier> suppliers = dao.getSuppliers(connectDB);

        result.add(subtypeProducts);
        result.add(statusProducts);
        result.add(suppliers);

        connectDB.close();
        return result;
    }
    }

