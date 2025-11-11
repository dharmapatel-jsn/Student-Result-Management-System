package com.mycompany.results.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    
    // !! EDIT THIS LINE !!
    private static final String DB_URL = "jdbc:mysql://localhost:3306/university_db";
    
    // !! IMPORTANT: Change these to your own MySQL username and password
    private static final String DB_USER = "root";
    private static final String DB_PASS = "root"; // <-- CHANGE THIS

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
    }
}