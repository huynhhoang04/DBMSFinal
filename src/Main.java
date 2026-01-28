import util.DBConnection;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) throws SQLException {
        Connection connection = DBConnection.getConnection();
        if(connection != null){
            System.out.println("Connected to the database");
        }
        else {
            System.out.println("Connection Failed");
        }
    }
}
