<%@page import="connection.DbCon,model.Product,dao.ProductDao" %>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<%
    // Fetch all products using ProductDao
    List<Product> products = null;
    try {
        ProductDao dao = new ProductDao(DbCon.getConnection());
        products = dao.getAllProducts();
        if (products == null || products.isEmpty()) {
            out.println("<p>No products available.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error fetching products. Please try again later.</p>");
    }
%>

<div class="container mt-5">
    <h2 class="mb-4">Product List</h2>
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
        <tr>
            <th>Name</th>
            <th>Price (RM)</th>
            <th>Quantity</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% 
            if (products != null && !products.isEmpty()) {
                for (Product p : products) {
                    System.out.println("Product ID: " + p.getId());
                    System.out.println("Product Name: " + p.getName());
                    System.out.println("Product Price: " + p.getPrice());
        %>
            <tr>
                <td><%= p.getName() %></td>
                <td><%= String.format("%.2f", p.getPrice()) %></td>
                <td>
                    <form action="order-now" method="post" class="form-inline">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <input type="number" name="quantity" class="form-control form-control-sm mr-2" value="1" min="1">
                </td>
                <td>
                        <button type="submit" class="btn btn-primary btn-sm">Buy</button>
                    </form>
                </td>
            </tr>
        <% 
                }
            } else {
                out.println("<tr><td colspan='4' class='text-center'>No products available.</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
