<%@page import="connection.DbCon"%>
<%@page import="dao.ProductDao"%>
<%@page import="model.Cart"%>
<%@ page import="java.util.*, model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
//add user login user auth

<% 
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	 ProductDao pDao = new ProductDao(DbCon.getConnection());
	 cartProduct = pDao.getCartProducts(cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("total", total);
	request.setAttribute("cart_list", cart_list);
%>


<!DOCTYPE html>
<html>
<head>
   
    <title>Your Shopping Cart</title>
</head>
<body>
    <h1>Your Shopping Cart</h1>

    <div class="cart">
        <div class="cart-ttprice">
            <%
                List<Product> cartList = (List<Product>) session.getAttribute("cartList");
                double totalPrice = 0;

                if (cartList != null && !cartList.isEmpty()) {
            %>
                <h2>Total Price: $
                    <%= cartList.stream().mapToDouble(Product::getPrice).sum() %>
                </h2>
                <a href="#">Checkout</a>

                <table>
                    <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Price</th>
                            <th scope="col">Buy Now</th>
                            <th scope="col">Cancel</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        
                     <%
				if (cart_list != null) {
					for (Cart c : cartProduct) {
				%>
                        <tr>
                            <td><%= c.getId() %></td>
                            <td><%= c.getName() %></td>
                            <td>$<%= c.getPrice() %></td>
                            <td>
                                <form action="order-now" method="post">
                                    <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                    <input type="hidden" name="quantity" value="1"/>
                                    <button type="submit">Buy Now</button>
                                </form>
                            </td>
                            <td>
                                <form action="remove-from-cart" method="post">
                                    <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                    <button type="submit">Remove</button>
                                </form>
                            </td>
                        </tr>
                      <%
				}}%>
                    </tbody>
                </table>
            <%
                } else {
            %>
                <h2>Your cart is empty!</h2>
            <%
                }
            %>
        </div>
    </div>

   
</body>
</html>
