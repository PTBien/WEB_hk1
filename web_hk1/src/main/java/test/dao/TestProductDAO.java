package test.dao;

import database.DbConnection;
import database.dao.ProductDAO;
import model.Product;

public class TestProductDAO {

    public TestProductDAO() {
    }

    public static void main(String[] args) {

        TestProductDAO test_dao = new TestProductDAO();

        test_dao.Test_GetSubTypeProducts();

    }

    public void Test_InsertProduct() {

        DbConnection connectDB = DbConnection.getInstance();
        Product p = new Product("img_1", "tranvanphuquy", "quytran", 10, 200000, 100000, 1, 1, 1);
        ProductDAO dao = new ProductDAO();
        System.out.println(dao.insertProduct(connectDB, p, "quytran"));

    }

    public void Test_InsertPriceProduct() {

        DbConnection connectDB = DbConnection.getInstance();
        Product p = new Product("img_1", "tranhoangquy", "quytran", 10, 200000, 100000, 1, 1, 1);
        p.setIdProduct(6);
        ProductDAO dao = new ProductDAO();
        System.out.println(dao.insertPriceProduct(connectDB, p, "quytran"));

    }

    public void Test_GetSubTypeProducts() {
        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        System.out.println(dao.getSubTypeProducts(connectDB));
    }

    public void Test_GetStatusProduct() {
        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        System.out.println(dao.getStatusProducts(connectDB));
    }

    public void Test_GetSuppliers() {
        DbConnection connectDB = DbConnection.getInstance();
        ProductDAO dao = new ProductDAO();
        System.out.println(dao.getSuppliers(connectDB));
    }

}

//test




