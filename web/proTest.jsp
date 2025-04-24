<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="connection.DbCon" %>
<%@ page import="model.ProductTest" %>

<%
    List<ProductTest> productList = new ArrayList<>();
    try (Connection conn = DbCon.getConnection();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery("SELECT * FROM PRODUCTS")) {

        // Debugging: Check if the query returns any data
        while (rs.next()) {
            ProductTest product = new ProductTest(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getString("image_url")
            );
            productList.add(product);
        }

        if (productList.isEmpty()) {
            // Debugging: If no products are found, print a message
            out.println("<p>No products found in the database.</p>");
        }

    } catch (SQLException e) {
        e.printStackTrace();
        // Debugging: Print error message
        out.println("<p style='color:red;'>Error fetching products: " + e.getMessage() + "</p>");
    }

    // Debugging: Check if the product list is empty
    if (productList.isEmpty()) {
        out.println("<p>No products to display.</p>");
    }
%>

<% for (ProductTest p : productList) { %>
    <div style="border:1px solid #ccc; padding:10px; margin:10px;">
        <p><strong><%= p.getName() %></strong></p>
        <p><%= p.getDescription() %></p>
        <p>RM <%= p.getPrice() %></p>
        <form method="post" action="cartTest.jsp">
            <input type="hidden" name="id" value="<%= p.getId() %>" />
            <input type="hidden" name="name" value="<%= p.getName() %>" />
            <input type="hidden" name="description" value="<%= p.getDescription() %>" />
            <input type="hidden" name="price" value="<%= p.getPrice() %>" />
            <input type="hidden" name="image_url" value="<%= p.getImageUrl() %>" />
            <button type="submit">Add to Cart</button>
        </form>
    </div>
<% } %>
