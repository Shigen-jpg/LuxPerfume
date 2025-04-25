package dao;
import connection.DbCon;
import model.ProductTest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOTest {
    private Connection conn;

    // Constructor
    public ProductDAOTest(Connection conn) {
        super();
        this.conn = conn;
    }

    // Insert a new product into the database
    public void insertProduct(ProductTest product) throws SQLException {
        String query = "INSERT INTO products (id, name, description, price, image_url, quantity) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, product.getId());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getQuantity());  // Added quantity to the insert statement
            stmt.executeUpdate();
        }
    }

    // Retrieve all products from the database
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
                    rs.getString("image_url"), 
                    rs.getInt("quantity")  // Retrieving quantity from the database
                );
                products.add(product);
            }
        }

        return products;
    }

    // Retrieve a product by its ID
    public ProductTest getProductById(int productId) throws SQLException {
        String query = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new ProductTest(
                    rs.getInt("id"),
                    rs.getString("name"),
                        rs.getString("description"),rs.getDouble("price"),
                    rs.getString("image_url"), 
                    rs.getInt("quantity")  // Retrieving quantity from the database
                );
            }
        }

        return null;  // Return null if no product is found
    }

    // Update a product in the database
    public void updateProduct(ProductTest product) throws SQLException {
        String query = "UPDATE products SET name = ?, description = ?, price = ?, image_url = ?, quantity = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getImageUrl());
            stmt.setInt(5, product.getQuantity());  // Update quantity
            stmt.setInt(6, product.getId());  // Set the product ID to identify the product to update
            stmt.executeUpdate();
        }
    }
}
