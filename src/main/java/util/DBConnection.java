package main.java.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        System.out.println("Current Path: " + new File(".").getAbsolutePath());
        try (InputStream is = DBConnection.class.getClassLoader().getResourceAsStream("dbconfig.properties")) {
            System.out.println(is);
            Class.forName("org.postgresql.Driver");
            Properties prop = new Properties();
            prop.load(is);
            String url = prop.getProperty("url");
            String username = prop.getProperty("user");
            String password = prop.getProperty("password");
            conn = DriverManager.getConnection(url, username, password);
            return conn;
        } catch (SQLException | ClassNotFoundException | IOException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
