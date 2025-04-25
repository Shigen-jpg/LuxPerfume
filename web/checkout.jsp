<%@ page import="java.sql.*, java.util.*, model.CartItemTest, model.ProductTest, connection.DbCon" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String selectedItemsStr = request.getParameter("selectedItems"); // Get selected items from query string
    double totalAmount = 0;
    List<CartItemTest> selectedCartItems = new ArrayList<>();

    try (Connection conn = DbCon.getConnection()) {
        if (conn != null && !conn.isClosed()) {

            if (selectedItemsStr != null && !selectedItemsStr.isEmpty()) {
                // Split the selectedItems string into an array of item IDs
                String[] selectedItems = selectedItemsStr.split(",");
                
                // Fetch the details of selected items from the database
                String query = "SELECT p.id, p.name, p.description, p.price, p.image_url, ci.quantity " +
                               "FROM CART_ITEMS ci JOIN PRODUCTS p ON ci.product_id = p.id WHERE p.id IN (" + 
                               String.join(",", selectedItems) + ")";
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
                    selectedCartItems.add(item);
                    totalAmount += item.getTotalPrice(); // Calculate total amount
                }

                rs.close();
                stmt.close();
            } else {
                out.println("<p>No items selected for checkout.</p>");
            }
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
</head>
<body>
    <h2>Checkout</h2>
    
    <% if (selectedCartItems.isEmpty()) { %>
        <p>No items selected for checkout. Please go back to the cart and select items.</p>
    <% } else { %>
        <h3>Selected Items:</h3>
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
                <% 
                    for (CartItemTest item : selectedCartItems) { 
                %>
                    <tr>
                        <td><%= item.getProduct().getName() %></td>
                        <td><%= item.getProduct().getDescription() %></td>
                        <td>RM <%= item.getProduct().getPrice() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>RM <%= item.getTotalPrice() %></td>
                    </tr>
                <% 
                    }
                %>
            </tbody>
        </table>

        <h3>Total Amount: RM <%= totalAmount %></h3>

<form action="orderCon.jsp" method="post" onsubmit="return validateForm()">
    <h3>Choose Payment Method</h3>
    <label for="paymentMethod">Select Payment Method:</label>
    <select name="paymentMethod" id="paymentMethod" required>
        <option value="cash">Cash</option>
        <option value="card">Credit/Debit Card</option>
        <option value="ewallet">E-wallet</option>
    </select>
    
    <!-- If card payment is selected, show card details -->
    <div id="cardDetails" style="display:none;">
        <h3>Card Information</h3>
        <label for="cardType">Card Type:</label>
        <select name="cardType" required>
            <option value="Visa">Visa</option>
            <option value="MasterCard">MasterCard</option>
        </select><br/><br/>
        
        <label for="cardNumber">Card Number:</label>
        <input type="text" name="cardNumber" id="cardNumber" required/><br/><br/>
        
        <label for="expiryDate">Expiry Date (MM/YY):</label>
        <input type="text" name="expiryDate" id="expiryDate" required/><br/><br/>
        
        <label for="cvv">CVV:</label>
        <input type="text" name="cvv" id="cvv" required/><br/><br/>
    </div>
    
    <!-- If cash payment is selected, show shipping details -->
    <div id="shippingDetails" style="display:none;">
        <h3>Shipping Information</h3>
        <label for="name">Name:</label>
        <input type="text" name="name" required/><br/><br/>
        
        <label for="address">Shipping Address:</label>
        <input type="text" name="address" required/><br/><br/>
        
        <label for="phone">Phone Number:</label>
        <input type="text" name="phone" required/><br/><br/>
    </div>
    
    <input type="hidden" name="selectedItems" value="<%= selectedItemsStr %>">
    <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
    <input type="submit" value="Confirm Payment"/>
</form>

<script>
document.getElementById("paymentMethod").addEventListener("change", function () {
        let paymentMethod = this.value;
        let cardDetails = document.getElementById("cardDetails");
        let shippingDetails = document.getElementById("shippingDetails");

        // Get card and shipping fields
        let cardFields = cardDetails.querySelectorAll("select, input");
        let shippingFields = shippingDetails.querySelectorAll("input");

        if (paymentMethod === "card") {
            cardDetails.style.display = "block";
            shippingDetails.style.display = "block";

            // Enable required for card and shipping fields
            cardFields.forEach(field => field.required = true);
            shippingFields.forEach(field => field.required = true);

        } else if (paymentMethod === "cash" || paymentMethod === "ewallet") {
            cardDetails.style.display = "none";
            shippingDetails.style.display = "block";

            // Remove required from card fields, add required to shipping
            cardFields.forEach(field => field.required = false);
            shippingFields.forEach(field => field.required = true);
        }
    });

    // Also trigger the change once on load to set initial state
    window.addEventListener("load", () => {
        document.getElementById("paymentMethod").dispatchEvent(new Event("change"));
    });

    // Validation function
    function validateForm() {
        var paymentMethod = document.getElementById("paymentMethod").value;
        
        if (paymentMethod == "card") {
            var cardNumber = document.getElementById("cardNumber").value;
            var expiryDate = document.getElementById("expiryDate").value;
            var cvv = document.getElementById("cvv").value;

            // Validate card number (16 digits)
            var cardNumberRegex = /^\d{16}$/;
            if (!cardNumberRegex.test(cardNumber)) {
                alert("Card number must be 16 digits.");
                return false;
            }

            // Validate expiry date (MM/YY format)
            var expiryDateRegex = /^(0[1-9]|1[0-2])\/\d{2}$/;
            if (!expiryDateRegex.test(expiryDate)) {
                alert("Expiry date must be in MM/YY format.");
                return false;
            }

            // Validate CVV (3 digits)
            var cvvRegex = /^\d{3}$/;
            if (!cvvRegex.test(cvv)) {
                alert("CVV must be 3 digits.");
                return false;
            }
        }

        if (paymentMethod == "cash") {
            var name = document.getElementsByName("name")[0].value;
            var address = document.getElementsByName("address")[0].value;
            var phone = document.getElementsByName("phone")[0].value;

            // Validate shipping details
            if (name == "" || address == "" || phone == "") {
                alert("Please fill in all shipping details.");
                return false;
            }
        }

        return true;  // If all validation passes
    }
</script>

    <% } %>

</body>
</html>
