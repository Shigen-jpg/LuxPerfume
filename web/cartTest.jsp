<%@ page import="java.sql.*, java.util.*, model.CartItemTest, model.ProductTest, connection.DbCon" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String idStr = request.getParameter("id");
    String deleteIdStr = request.getParameter("deleteId");
    String updateIdStr = request.getParameter("updateId");
    String newQuantityStr = request.getParameter("newQuantity");
    String[] selectedItems = request.getParameterValues("selectedItems"); // Get selected items
    int quantityToAdd = 1;
    double totalAmount = 0;  // Variable to store total amount of selected items

    try (Connection conn = DbCon.getConnection()) {
        if (conn != null && !conn.isClosed()) {

            // Add to Cart
            if (idStr != null) {
                int productId = Integer.parseInt(idStr);
                PreparedStatement checkStmt = conn.prepareStatement("SELECT quantity FROM CART_ITEMS WHERE product_id = ?");
                checkStmt.setInt(1, productId);
                ResultSet rsCheck = checkStmt.executeQuery();

                if (rsCheck.next()) {
                    int currentQty = rsCheck.getInt("quantity");
                    PreparedStatement updateStmt = conn.prepareStatement("UPDATE CART_ITEMS SET quantity = ? WHERE product_id = ?");
                    updateStmt.setInt(1, currentQty + quantityToAdd);
                    updateStmt.setInt(2, productId);
                    updateStmt.executeUpdate();
                    updateStmt.close();
                } else {
                    PreparedStatement insertStmt = conn.prepareStatement("INSERT INTO CART_ITEMS (product_id, quantity) VALUES (?, ?)");
                    insertStmt.setInt(1, productId);
                    insertStmt.setInt(2, quantityToAdd);
                    insertStmt.executeUpdate();
                    insertStmt.close();
                }
                rsCheck.close();
                checkStmt.close();
            }

            // Delete from Cart
            if (deleteIdStr != null) {
                int deleteProductId = Integer.parseInt(deleteIdStr);
                PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM CART_ITEMS WHERE product_id = ?");
                deleteStmt.setInt(1, deleteProductId);
                deleteStmt.executeUpdate();
                deleteStmt.close();

                response.sendRedirect("cartTest.jsp");
                return;
            }

            // Update Quantity
            if (updateIdStr != null && newQuantityStr != null) {
                int updateProductId = Integer.parseInt(updateIdStr);
                int newQuantity = Integer.parseInt(newQuantityStr);
                PreparedStatement updateQuantityStmt = conn.prepareStatement("UPDATE CART_ITEMS SET quantity = ? WHERE product_id = ?");
                updateQuantityStmt.setInt(1, newQuantity);
                updateQuantityStmt.setInt(2, updateProductId);
                updateQuantityStmt.executeUpdate();
                updateQuantityStmt.close();

                response.sendRedirect("cartTest.jsp");
                return;
            }

            // Load Cart Items
            List<CartItemTest> cartItems = new ArrayList<>();
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
                    rs.getString("image_url"),
                    rs.getInt("quantity")
                );
                CartItemTest item = new CartItemTest(product, rs.getInt("quantity"));
                cartItems.add(item);

                // If item is selected, calculate its total price
                if (selectedItems != null && Arrays.asList(selectedItems).contains(String.valueOf(product.getId()))) {
                    totalAmount += item.getTotalPrice();  // Add item total price to the total amount
                }
            }

            rs.close();
            stmt.close();

%>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart</title>
    <script>
        function confirmDelete(productName) {
            return confirm("Are you sure you want to delete '" + productName + "' from your cart?");
        }

        // Function to calculate total amount from selected items
        function calculateTotal() {
            var total = 0;
            var checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
            checkboxes.forEach(function(checkbox) {
                var price = parseFloat(checkbox.getAttribute('data-price')); // Get price of selected item
                var quantity = parseInt(checkbox.getAttribute('data-quantity')); // Get quantity of selected item
                total += price * quantity; // Calculate total price for selected items
            });
            document.getElementById('totalPrice').innerHTML = "Total Price: RM " + total.toFixed(2);
        }

        // Function to handle checkout action
        function checkout() {
            var selectedItems = [];
            var checkboxes = document.querySelectorAll('input[name="selectedItems"]:checked');
            checkboxes.forEach(function(checkbox) {
                selectedItems.push(checkbox.value); // Add selected item id to array
            });

            if (selectedItems.length > 0) {
                // Redirect to checkout page with selected items as query parameters
                window.location.href = "checkout.jsp?selectedItems=" + selectedItems.join(",");
            } else {
                alert("Please select items to checkout.");
            }
        }
    </script>
</head>
<body>
    <h3>Cart Items:</h3>

    <% if (cartItems.isEmpty()) { %>
        <p>No items in cart.</p>
    <% } else { 
        for (CartItemTest item : cartItems) { %>
        <div style="border:1px solid #ccc; padding:10px; margin:10px;">
            <p><strong><%= item.getProduct().getName() %></strong></p>
            <p>Quantity: 
                <form action="cartTest.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="updateId" value="<%= item.getProduct().getId() %>" />
                    <input type="number" name="newQuantity" value="<%= item.getQuantity() %>" min="1" 
                           style="width:50px;" onchange="this.form.submit()" />
                </form>
            </p>
            <p>Total Price: RM <%= item.getTotalPrice() %></p>

            <form action="cartTest.jsp" method="post" style="display:inline;" onsubmit="return confirmDelete('<%= item.getProduct().getName() %>');">
                <input type="hidden" name="deleteId" value="<%= item.getProduct().getId() %>" />
                <button type="submit" style="background-color:#f44336; color:white; border:none; padding:5px 10px; cursor:pointer;">
                    Delete
                </button>
            </form>

            <!-- Add Checkbox for Item Selection -->
            <form action="cartTest.jsp" method="post" style="display:inline;">
                <input type="checkbox" name="selectedItems" value="<%= item.getProduct().getId() %>" 
                       data-price="<%= item.getProduct().getPrice() %>" 
                       data-quantity="<%= item.getQuantity() %>" onchange="calculateTotal()" />
                <label for="selectedItems">Select</label>
            </form>
        </div>
    <% } } %>

    <h3 id="totalPrice">Total Price: RM <%= totalAmount %></h3>  <!-- Display total price -->

    <!-- Checkout Button -->
    <button onclick="checkout()" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
        Proceed to Checkout
    </button>

</body>
</html>
<%
        } else {
            out.println("<p style='color:red;'>Database connection failed.</p>");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>
