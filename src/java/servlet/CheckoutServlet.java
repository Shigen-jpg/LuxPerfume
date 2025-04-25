package servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.*;
import connection.DbCon;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CheckoutServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<CartItemTest> cartItems = new ArrayList<>();
        int index = 0;

        try (Connection conn = DbCon.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                while (true) {
                    String productIdStr = request.getParameter("items[" + index + "].productId");
                    String quantityStr = request.getParameter("items[" + index + "].quantity");

                    if (productIdStr == null || quantityStr == null) {
                        break;
                    }

                    try {
                        int productId = Integer.parseInt(productIdStr);
                        int quantity = Integer.parseInt(quantityStr);

                        // Fetch product details from the database
                        String query = "SELECT id, name, description, price, image_url FROM PRODUCTS WHERE id = ?";
                        try (PreparedStatement stmt = conn.prepareStatement(query)) {
                            stmt.setInt(1, productId);
                            ResultSet rs = stmt.executeQuery();

                            if (rs.next()) {
                                ProductTest product = new ProductTest(
                                        rs.getInt("id"),
                                        rs.getString("name"),
                                        rs.getString("description"),
                                        rs.getDouble("price"),
                                        rs.getString("image_url"),
                                        quantity
                                );
                                CartItemTest item = new CartItemTest(product, quantity);
                                cartItems.add(item);
                            }
                            rs.close();
                        }
                    } catch (NumberFormatException | SQLException e) {
                        LOGGER.log(Level.SEVERE, "Error processing product at index " + index + ": " + e.getMessage(), e);
                    }

                    index++;
                }

                if (cartItems.isEmpty()) {
                    request.setAttribute("message", "No valid items for checkout.");
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    return;
                }

                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        } catch (ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "Class not found error: " + ex.getMessage(), ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error.");
        }
    }
}
