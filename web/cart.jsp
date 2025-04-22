<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
</head>
<body>
    <h1>Your Shopping Cart</h1>

    <c:if test="${not empty cart}">
        <table border="1">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${cart.items}">
                    <tr>
                        <td>${item.product.name}</td>
                        <td>${item.quantity}</td>
                        <td>${item.product.price}</td>
                        <td>${item.totalPrice}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h3>Total Price: ${cart.totalPrice}</h3>
    </c:if>

    <c:if test="${empty cart}">
        <p>Your cart is empty!</p>
    </c:if>
</body>
</html>
