<%@ page import="java.sql.*, java.util.*, model.CartItemTest, model.ProductTest, connection.DbCon" %>
<%
    request.setCharacterEncoding("UTF-8");

    String paymentMethod = request.getParameter("paymentMethod");
    String selectedItemsStr = request.getParameter("selectedItems");
    String totalAmount = request.getParameter("totalAmount");

    String cardType = request.getParameter("cardType");
    String cardNumber = request.getParameter("cardNumber");
    String expiryDate = request.getParameter("expiryDate");
    String cvv = request.getParameter("cvv");

    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");

    List<CartItemTest> purchasedItems = new ArrayList<>();

    try (Connection conn = DbCon.getConnection()) {
        if (conn != null && !conn.isClosed() && selectedItemsStr != null) {
            String[] selectedIds = selectedItemsStr.split(",");
            String placeholders = String.join(",", selectedIds);

            String sql = "SELECT p.id, p.name, p.description, p.price, p.image_url, ci.quantity " +
                         "FROM CART_ITEMS ci JOIN PRODUCTS p ON ci.product_id = p.id " +
                         "WHERE p.id IN (" + placeholders + ")";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductTest product = new ProductTest(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url"),
                    rs.getInt("quantity")
                );
                CartItemTest item = new CartItemTest(product, rs.getInt("quantity"));
                purchasedItems.add(item);
            }

            rs.close();
            stmt.close();
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
</head>
<body>
    <h2>Order Confirmation</h2>

    <h3>Payment Method: <%= paymentMethod %></h3>

    <% if ("card".equals(paymentMethod)) { %>
        <h4>Card Details</h4>
        <p>Card Type: <%= cardType %></p>
        <p>Card Number: **** **** **** <%= cardNumber.substring(cardNumber.length() - 4) %></p>
        <p>Expiry Date: <%= expiryDate %></p>
    <% } %>

    <% if ("cash".equals(paymentMethod) || "card".equals(paymentMethod) || "ewallet".equals(paymentMethod)) { %>
        <h4>Shipping Information</h4>
        <p>Name: <%= name %></p>
        <p>Address: <%= address %></p>
        <p>Phone: <%= phone %></p>
    <% } %>

    <h3>Purchased Items</h3>
    <table border="1" cellpadding="10">
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <% for (CartItemTest item : purchasedItems) { %>
                <tr>
                    <td><%= item.getProduct().getName() %></td>
                    <td><%= item.getProduct().getDescription() %></td>
                    <td>RM <%= item.getProduct().getPrice() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td>RM <%= item.getTotalPrice() %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <h3>Total Amount Paid: RM <%= totalAmount %></h3>

    <p>Thank you for your purchase! Your order has been placed successfully.</p>
</body>
</html>
