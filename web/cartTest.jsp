<%@ page import="java.util.*, model.CartItemTest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="connection.DbCon" %>
<html>
<head>
    <title>Your Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 30px auto;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
        .total {
            font-weight: bold;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">🛒 Your Shopping Cart</h2>

<%
    List<CartItemTest> cartItems = (List<CartItemTest>) session.getAttribute("cartItems");
    double grandTotal = 0.0;

    if (cartItems == null || cartItems.isEmpty()) {
%>
        <p style="text-align:center;">Your cart is empty.</p>
<%
    } else {
%>
        <table>
            <tr>
                <th>Product</th>
                <th>Description</th>
                <th>Image</th>
                <th>Price (RM)</th>
                <th>Quantity</th>
                <th>Total (RM)</th>
            </tr>
<%
            for (CartItemTest item : cartItems) {
                grandTotal += item.getTotalPrice();
%>
            <tr>
                <td><%= item.getProduct().getName() %></td>
                <td><%= item.getProduct().getDescription() %></td>
                <td><img src="<%= item.getProduct().getImageUrl() %>" width="80" /></td>
                <td><%= item.getProduct().getPrice() %></td>
                <td><%= item.getQuantity() %></td>
                <td><%= item.getTotalPrice() %></td>
            </tr>
<%
            }
%>
            <tr>
                <td colspan="5" class="total">Grand Total</td>
                <td class="total">RM <%= String.format("%.2f", grandTotal) %></td>
            </tr>
        </table>
<%
    }
%>

</body>
</html>
