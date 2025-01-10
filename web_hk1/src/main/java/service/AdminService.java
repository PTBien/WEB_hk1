package service;

import database.DbConnection;
import model.Account;
import model.Admin;
import model.Bill;
import model.Product;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AdminService {

    public static boolean updatePassword(String username, String new_pass) {

        DbConnection connectDB = DbConnection.getInstance();
        String sql = "update account_admin set passwordAD = ?, time_change_pass = current_timestamp() where username = ?";
        PreparedStatement preState = connectDB.getPreparedStatement(sql);
        try {
            preState.setString(1, new_pass);
            preState.setString(2, username);
            int update = preState.executeUpdate();
            if (update > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            connectDB.close();
        }

        return false;
    }

    public static Admin checkLogin(String username, String passAD) {
        List<Admin> admins = new ArrayList<>();
        DbConnection connectDB = DbConnection.getInstance();
        String sql = "select username,passwordAD,id_role_admin,id_status_acc,fullname from account_admin where username = ?";
        PreparedStatement preState = connectDB.getPreparedStatement(sql);
        try {
            preState.setString(1, username);
            ResultSet rs = preState.executeQuery();
            while (rs.next()) {
                String user_name = rs.getString("username");
                String password = rs.getString("passwordAD");
                int id_role_admin = rs.getInt("id_role_admin");
                int id_status_acc = rs.getInt("id_status_acc");
                String full_name = rs.getString("fullname");
                Admin admin = new Admin(user_name, password, id_role_admin, id_status_acc, full_name);
                admins.add(admin);
            }

            if (admins.size() != 1) return null; // không thể tồn tại nhiều username trùng tên trong hệ thống

            Admin admin = admins.get(0);
            if (admin.getPassAD().equals(passAD)) return admin;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            connectDB.close();
        }
        return null;
    }

    public static int getTotalCancelOrders() {
        try (PreparedStatement ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT COUNT(*) FROM bills WHERE id_status_bill = ?")) {
            ps.setInt(1, 3);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            return 0;
        }
    }

    public static double getTotalRevenue() {
        try (PreparedStatement ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT SUM(total_price) FROM bills")) {
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            return 0;
        }
    }

    public static List<Bill> getBillsOrderedIn(int month) {
        List<Bill> bills = new ArrayList<>();
        try (var ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT id_bill, name_status_bill, fullname_customer, total_price, address_customer, time_order " +
                        "FROM bills b JOIN status_bill s ON b.id_status_bill = s.id_status_bill " +
                        "WHERE MONTH(time_order) = ? AND YEAR(time_order) = YEAR(CURRENT_DATE)")) {
            ps.setInt(1, month);
            var rs = ps.executeQuery();
            while (rs.next()) {
                int billId = rs.getInt("id_bill");
                List<Product> products = ProductService.getProductsByBillId(billId);
                String status = rs.getString("name_status_bill");
                String address = rs.getString("address_customer");
                String customer = rs.getString("fullname_customer");
                int quantity = CustomerService.getQuantityByBillId(billId);
                double totalPrice = rs.getDouble("total_price");
                Date timeOrder = rs.getDate("time_order");
                bills.add(new Bill(billId, products, status, address, customer, quantity, totalPrice, timeOrder));
            }
            return bills;
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public static int getCustomersCreatedIn(int month) {
        try (var ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT DISTINCT COUNT(*) FROM account_customer " +
                        "WHERE MONTH(time_created) = ? AND YEAR(time_created) = YEAR(CURRENT_DATE)")) {
            ps.setInt(1, month);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            return 0;
        }
    }

    public static double getRevenueFor(int month) {
        try (var ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT SUM(total_price) FROM bills " +
                        "WHERE MONTH(time_order) = ? AND YEAR(time_order) = YEAR(CURRENT_DATE) " +
                        "GROUP BY MONTH(time_order)")) {
            ps.setInt(1, month);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getDouble(1);
        } catch (SQLException e) {
            return 0;
        }
    }

    public static List<Bill> getRecentOrderedBills(int day) {
        List<Bill> bills = new ArrayList<>();
        try (PreparedStatement ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT b.id_bill, name_status_bill, fullname_customer, total_price, time_order, " +
                        "address_customer FROM bills b JOIN status_bill s ON b.id_status_bill = s.id_status_bill " +
                        "WHERE DATE(time_order) > (NOW() - INTERVAL ? DAY) ORDER BY time_order DESC LIMIT 0,4")) {
            ps.setInt(1, day);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id_bill");
                List<Product> products = ProductService.getProductsByBillId(id);
                String status = rs.getString("name_status_bill");
                String customerName = rs.getString("fullname_customer");
                String address = rs.getString("address_customer");
                int quantity = CustomerService.getQuantityByBillId(id);
                double totalPrice = rs.getDouble("total_price");
                Date timeOrder = rs.getDate("time_order");
                bills.add(new Bill(id, products, status, address, customerName, quantity, totalPrice, timeOrder));
            }
        } catch (SQLException e) {
            return new ArrayList<>();
        }
        return bills;
    }

    public static int getBillCounts() {
        return getNumberOf("bills");
    }

    public static int getCustomerCounts() {
        return getNumberOf("account_customer");
    }

    public static int getProductCounts() {
        return getNumberOf("products");
    }

    private static int getNumberOf(String table) {
        try (Statement st = DbConnection.getInstance().getStatement()) {
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM " + table);
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            return 0;
        }
    }

    public static List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        try (var ps = DbConnection.getInstance().getPreparedStatement(
                "SELECT id_user_customer, username, pass, name_status_acc, email_customer, time_created\n" +
                        "FROM account_customer a JOIN status_acc s ON a.id_status_acc = s.id_status_acc"
        )) {
            var rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id_user_customer");
                String username = rs.getString("username");
                String password = rs.getString("pass");
                String status = rs.getString("name_status_acc");
                String email = rs.getString("email_customer");
                Date time = rs.getDate("time_created");
                accounts.add(new Account(id, username, password, status, email, time));
            }
            return accounts;
        } catch (SQLException e) {
            return new ArrayList<>();
        }
    }
}
