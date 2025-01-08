package database.dao;

import database.DbConnection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.Executors;

public class CustomerDao {

    public void deleteAccount(int id) {
        Executors.newSingleThreadExecutor().execute(() -> {
            try (var ps = DbConnection.getInstance().getPreparedStatement(
                    "DELETE FROM account_customer WHERE id_user_customer = ?"
            )) {
                ps.setInt(1, id);
                ps.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        });
    }

    public void updateAccount(int id, String username, String password, int status, String email) {
        Executors.newSingleThreadExecutor().execute(() -> {
            try (var ps = DbConnection.getInstance().getPreparedStatement(
                    "UPDATE account_customer SET username = ?, pass = ?, id_status_acc = ?, email_customer = ? " +
                            "WHERE id_user_customer = ?")) {
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setInt(3, status);
                ps.setString(4, email);
                ps.setInt(5, id);
                ps.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        });
    }

    public int addBill(int userId, int cityId, String name, String phone, String email,
                              String address, double price, double totalPrice) {
        try (var ps = DbConnection.getInstance()
                .getPreparedStatement("INSERT INTO bills VALUES (0,?,4,?,?,?,?,?,?,?,NOW())")) {
            ps.setInt(1, userId);
            ps.setInt(2, cityId);
            ps.setString(3, name);
            ps.setString(4, phone);
            ps.setString(5, email);
            ps.setString(6, address);
            ps.setDouble(7, price);
            ps.setDouble(8, totalPrice);
            ps.executeUpdate();
            try (var ps2 = DbConnection.getInstance().getPreparedStatement("SELECT LAST_INSERT_ID()")) {
                ResultSet rs = ps2.executeQuery();
                rs.next();
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            return -1;
        }
    }

    public void addBillDetail(int billId, int productId, int quantity, double listedPrice, double currentPrice) {
        Executors.newSingleThreadExecutor().execute(() -> {
            try (var ps = DbConnection.getInstance().getPreparedStatement(
                    "INSERT INTO bill_detail VALUES (?,?,?,?,?)")) {
                ps.setInt(1, billId);
                ps.setInt(2, productId);
                ps.setInt(3, quantity);
                ps.setDouble(4, listedPrice);
                ps.setDouble(5, currentPrice);
                ps.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        });
    }

    public void updateBill(int billId, String cus, double price, int status, String address) {
        Executors.newSingleThreadExecutor().execute(() -> {
            try (var ps = DbConnection.getInstance().getPreparedStatement(
                    "UPDATE bills SET fullname_customer = ?, address_customer = ?, total_price = ?, " +
                            "id_status_bill = ? WHERE id_bill = ?"
            )) {
                ps.setString(1, cus);
                ps.setString(2, address);
                ps.setDouble(3, price);
                ps.setInt(4, status);
                ps.setInt(5, billId);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        });
    }

    public void cancelOrder(int idBill) {
        Executors.newSingleThreadExecutor().execute(() -> {
            try (PreparedStatement ps = DbConnection.getInstance().getPreparedStatement(
                    "UPDATE bills SET id_status_bill = 3 WHERE id_bill = ?"
            )) {
                ps.setInt(1, idBill);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        });
    }
}
