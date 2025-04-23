<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Products</title>
    <style>
        .container { padding: 20px; }
        .card { border: 1px solid #ccc; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .card-title { font-size: 18px; font-weight: bold; }
        .price { color: green; }
        .actions a { margin-right: 10px; text-decoration: none; color: blue; }
    </style>
</head>
<body>

<div class="container">
    <h2>All Products</h2>
    <div class="row">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LuxPerfume", "nbuser", "nbuser");

                String query = "SELECT id, pro_name, price FROM product";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);

                boolean hasProducts = false;
                while (rs.next()) {
                    hasProducts = true;
                    int id = rs.getInt("id");
                    String name = rs.getString("pro_name");
                    double price = rs.getDouble("price");
        %>
        <div class="col-md-3">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><%= name %></h5>
                    <h6 class="price">Price: $<%= price %></h6>
                    <div class="actions">
                        <a href="add-to-cart?id=<%= p.getId() %>">Add to Cart</a>
                        <a href="order-now?quantity=1&id=<%= id %>">Buy Now</a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }

                if (!hasProducts) {
                    out.println("<p>There are no products.</p>");
                }

            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        %>
    </div>
</div>

</body>
</html>
