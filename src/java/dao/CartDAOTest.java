package dao;
import model.CartItemTest;
import model.ProductTest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOTest {
    private final Connection conn;

    public CartDAOTest(Connection conn) {
        this.conn = conn;
    }

    public void addToCart(int productId, int quantity) throws SQLException {
        String query = "INSERT INTO cart_items (product_id, quantity) VALUES (?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, quantity);
            stmt.executeUpdate();
        }
    }

    public List<CartItemTest> getCartItems(ProductDAOTest productDAO) throws SQLException {
        List<CartItemTest> cartItems = new ArrayList<>();
        String query = "SELECT * FROM cart_items";

        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");

                ProductTest product = productDAO.getProductById(productId);
                if (product != null) {
                    cartItems.add(new CartItemTest(product, quantity));
                }
            }
        }

        return cartItems;
    }
}
