package servlet;

import connection.DbCon;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Payment;
import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve payment method and order details from the form
        String paymentMethod = request.getParameter("paymentMethod");
        String shippingAddress = request.getParameter("shippingAddress");
        String name = request.getParameter("name");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        
        // Create a Payment object to represent the order
        Payment payment = new Payment(paymentMethod, totalAmount, shippingAddress, name);

        // Process payment and store order information in the database
        boolean paymentSuccess = false;
        try {
            paymentSuccess = processPayment(payment);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (paymentSuccess) {
            request.setAttribute("orderId", payment.getOrderId());
            request.setAttribute("orderDate", payment.getOrderDate());
            request.setAttribute("message", "Your order has been successfully submitted!");
            request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "There was an error processing your payment. Please try again.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    private boolean processPayment(Payment payment) throws ClassNotFoundException {
        // Logic for processing payment (card validation, cash processing, etc.)
        // Store the order details in the database
        // For now, just simulate successful payment
        try (Connection conn = DbCon.getConnection()) {
            String sql = "INSERT INTO orders (order_id, payment_method, total_amount, shipping_address, name, order_date) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, payment.getOrderId());
                stmt.setString(2, payment.getPaymentMethod());
                stmt.setDouble(3, payment.getTotalAmount());
                stmt.setString(4, payment.getShippingAddress());
                stmt.setString(5, payment.getName());
                stmt.setString(6, payment.getOrderDate());

                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            return false;
        }
    }
}
