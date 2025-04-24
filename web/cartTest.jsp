<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="model.ProductTest" %>
<%@ page import="model.CartItemTest" %>
<%@ page import="connection.DbCon" %>

<%
    String idStr = request.getParameter("id");
    int quantityToAdd = 1;

    if (idStr != null) {
        int productId = Integer.parseInt(idStr);

        try {
            Connection conn = DbCon.getConnection();

            if (conn != null && !conn.isClosed()) {
                // Check if product already exists in CART_ITEMS
                PreparedStatement checkStmt = conn.prepareStatement("SELECT quantity FROM CART_ITEMS WHERE product_id = ?");
                checkStmt.setInt(1, productId);
                ResultSet rsCheck = checkStmt.executeQuery();

                if (rsCheck.next()) {
                    // Already exists ? update quantity
                    int currentQty = rsCheck.getInt("quantity");
                    PreparedStatement updateStmt = conn.prepareStatement("UPDATE CART_ITEMS SET quantity = ? WHERE product_id = ?");
                    updateStmt.setInt(1, currentQty + quantityToAdd);
                    updateStmt.setInt(2, productId);
                    updateStmt.executeUpdate();
                    updateStmt.close();
                } else {
                    // New product ? insert into CART_ITEMS
                    PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO CART_ITEMS (product_id, quantity) VALUES (?, ?)");
                    insertStmt.setInt(1, productId);
                    insertStmt.setInt(2, quantityToAdd);
                    insertStmt.executeUpdate();
                    insertStmt.close();
                }

                rsCheck.close();
                checkStmt.close();
            }

        } catch (SQLException | ClassNotFoundException e) {
            out.println("<p style='color:red;'>Error adding to cart: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }

    // Load updated cart from DB
    List<CartItemTest> cartItems = new ArrayList<>();

    try {
        Connection conn = DbCon.getConnection();
        if (conn != null && !conn.isClosed()) {
            String query = "SELECT p.id, p.name, p.description, p.price, p.image_url, ci.quantity " +
                           "FROM CART_ITEMS ci JOIN PRODUCTS p ON ci.product_id = p.id";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductTest product = new ProductTest(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url")
                );
                CartItemTest item = new CartItemTest(product, rs.getInt("quantity"));
                cartItems.add(item);
            }

            session.setAttribute("cartItems", cartItems);

            rs.close();
            stmt.close();
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("<p style='color:red;'>Error retrieving cart: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }

    out.println("<h3>Cart Items:</h3>");
    if (cartItems.isEmpty()) {
        out.println("<p>No items in cart.</p>");
    } else {
        for (CartItemTest item : cartItems) {
%>
            <div style="border:1px solid #ccc; padding:10px; margin:10px;">
                <p><strong><%= item.getProduct().getName() %></strong></p>
                <p>Quantity: <%= item.getQuantity() %></p>
                <p>Total Price: RM <%= item.getTotalPrice() %></p>
            </div>
<%
        }
    }
%>
