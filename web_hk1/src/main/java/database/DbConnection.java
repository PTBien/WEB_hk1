package database;

import java.sql.*;

public class DbConnection {
    private static final String url = "jdbc:mysql://" + DbProperties.host() + ":" + DbProperties.port() + "/" + DbProperties.dbName();
    private static DbConnection INSTANCE = null;
    private final Connection conn;

    private DbConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, DbProperties.user(), DbProperties.pass());
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static DbConnection getInstance() {
        if (INSTANCE == null) INSTANCE = new DbConnection();
        return INSTANCE;
    }

    public void close() {
        try {
            conn.close();
            INSTANCE = null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // thường dùng để thực thi các câu lệnh sql không có tham số
    public Statement getStatement() {
        if (conn == null) return null;
        try {
            return conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        } catch (SQLException e) {
            // throw new RuntimeException(e);
            return null;
        }
    }

    public Statement getUpdatableStatement() {
        if (conn == null) return null;
        try {
            return conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        } catch (SQLException e) {
            return null;
        }
    }

    // thường dùng để thực thi các câu lệnh sql có tham số truyền vào
    public PreparedStatement getPreparedStatement(String sql) {
        if (conn == null) return null;
        try {
            return conn.prepareStatement(sql);
        } catch (SQLException e) {
            // throw new RuntimeException(e);
            return null;
        }
    }

    public Connection getConn() {
        return conn;
    }
}
