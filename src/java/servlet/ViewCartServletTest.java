package servlet;

import dao.CartDAOTest;
import dao.ProductDAOTest;
import dao.CartInitializerTest;
import model.CartItemTest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/view-cart")  // Access this servlet at /view-cart
public class ViewCartServletTest extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Connect to your Derby DB
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ecommerceDB", "app", "app");

            // 2. Initialize DAO
            ProductDAOTest productDAO = new ProductDAOTest(conn);
            CartDAOTest cartDAO = new CartDAOTest(conn);

            // 3. Initialize the cart with test data
            // Ensure that this initializer is called
            CartInitializerTest.initializeCart(cartDAO);

            // 4. Get cart items from the session or DAO
            List<CartItemTest> cartItems = cartDAO.getCartItems(productDAO);

            // 5. Store cart in session
            HttpSession session = request.getSession();
            session.setAttribute("cartItems", cartItems);

            // 6. Redirect to the JSP page
            response.sendRedirect("cart.jsp");

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
