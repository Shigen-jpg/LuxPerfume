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

    public void insertProduct(ProductTest product) throws SQLException {
        String query = "INSERT INTO products (id, name, description, price, image_url) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, product.getId());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setString(5, product.getImageUrl());
            stmt.executeUpdate();
        }
    }

    public List<ProductTest> getAllProducts() throws SQLException {
        List<ProductTest> products = new ArrayList<>();
        String query = "SELECT * FROM products";

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
