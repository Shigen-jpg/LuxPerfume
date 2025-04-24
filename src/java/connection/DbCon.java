package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {
    private static Connection connection = null;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        if (connection == null) {
            // Load the Derby JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Connect to Derby database
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/Perfume", "nbuser", "nbuser");
            System.out.println("Connected to Derby database.");
        }
        return connection;
    }
}
