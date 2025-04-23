package yourpackage;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            return DriverManager.getConnection("jdbc:derby://localhost:1527/AdminDB", "nbuser", "nbuser");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
