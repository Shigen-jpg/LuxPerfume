package dao;

import dao.CartDAOTest;
import java.sql.SQLException;

public class CartInitializerTest {

    public static void initializeCart(CartDAOTest cartDAO) {
        try {
            // Add test items to the cart — assumes product IDs 1 and 2 already exist in the 'products' table
            cartDAO.addToCart(1, 2); // 2 units of product ID 1
            cartDAO.addToCart(2, 1); // 1 unit of product ID 2

            System.out.println("Cart initialized with test data.");
        } catch (SQLException e) {
            System.out.println("Error initializing cart: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
