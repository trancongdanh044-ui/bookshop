package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // Use environment variables or system properties for credentials
    private static final String URL = System.getProperty("db.url", "jdbc:mysql://localhost:3306/bookshop_v2?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC");
    private static final String USER = System.getProperty("db.user", "root");
    private static final String PASSWORD = System.getProperty("db.password", "danh1112005A@");

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static String getConfiguredUrl() {
        return URL;
    }
}
