
package servlet;

import connection.DbCon;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.*;


/**
 *
 * @author chloe
 */
@WebServlet(name = "CheckTest", urlPatterns = {"/CheckTest"})
public class CheckTest extends HttpServlet {




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
                    } catch (NumberFormatException e) {
            
    request.setAttribute("errorMessage", "Database error occurred. Please try again later.");

        }

                    index++;
                }

                if (cartItems.isEmpty()) {
                    request.setAttribute("message", "No valid items for checkout.");
                    request.getRequestDispatcher("cartTest.jsp").forward(request, response);
                    return;
                }

                request.setAttribute("cartItems", cartItems);
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } catch (SQLException e) {
    e.printStackTrace(); 
    request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "Server error occurred. Please try again later.");
}

    }

    
    

}
