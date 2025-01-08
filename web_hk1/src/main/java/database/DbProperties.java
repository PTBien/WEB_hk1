package database;

import java.io.IOException;
import java.util.Properties;

public final class DbProperties {
    private static final String PROP_PATH = "db.properties";
    private static final Properties PROP = new Properties();

    static {
        try {
            PROP.load(DbProperties.class.getClassLoader().getResourceAsStream(PROP_PATH));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private DbProperties() {
        throw new AssertionError();
    }

    public static String host() {
        return PROP.getProperty("host");
    }

    public static String port() {
        return PROP.getProperty("port");
    }

    public static String user() {
        return PROP.getProperty("user");
    }

    public static String pass() {
        return PROP.getProperty("pass");
    }

    public static String dbName() {
        return PROP.getProperty("dbName");
    }
}
