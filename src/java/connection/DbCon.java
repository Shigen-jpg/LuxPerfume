package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {
    private static Connection connection = null;

    // Method to get or establish a connection
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        // Check if the connection is null or closed
        if (connection == null || connection.isClosed()) {
            // Load the Derby JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Connect to the Derby database
            String url = "jdbc:derby://localhost:1527/perfume";
            String user = "nbuser";
            String password = "nbuser";

            connection = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Connected to Derby database.");
        }
        return connection;
    }

    // Method to close the connection safely
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("🔌 Connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("❌ Error closing connection: " + e.getMessage());
        }
    }
}
