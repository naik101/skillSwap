package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database configuration
    private static final String URL = "jdbc:mysql://localhost:3306/skillswap";
    private static final String USER = "root";
    private static final String PASSWORD = "root123";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found. Ensure it is added to your project path.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Failed to connect to the database. Check credentials and ensure MySQL is running.");
            e.printStackTrace();
        }
        return connection;
    }
}
