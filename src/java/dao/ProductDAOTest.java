package dao;
import connection.DbCon;

import model.ProductTest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOTest {
    private Connection conn;

    public ProductDAOTest(Connection conn) {
        super();
        this.conn = conn;
    }

    public List<ProductTest> getAllProducts() throws SQLException {
        List<ProductTest> products = new ArrayList<>();
        String query = "SELECT * FROM products"; // Your table name may vary

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                ProductTest product = new ProductTest(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url")
                );
                products.add(product);
            }
        }

        return products;
    }

    public ProductTest getProductById(int productId) throws SQLException {
        String query = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new ProductTest(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url")
                );
            }
        }

        return null;
    }
}
