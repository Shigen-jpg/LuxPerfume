<%@page import="connection.DbCon,model.*,dao.ProductDao" %>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart | Luxe Essence</title>
    <style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Cormorant Garamond', 'Times New Roman', serif;
}

body {
    background-color: #f8f8f8;
    color: #333;
    line-height: 1.6;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

.btn {
    display: inline-block;
    background-color: transparent;
    color: #333;
    border: 1px solid #a67c52;
    padding: 12px 30px;
    font-size: 14px;
    letter-spacing: 2px;
    text-transform: uppercase;
    text-decoration: none;
    transition: all 0.3s ease;
    cursor: pointer;
}

.btn:hover {
    background-color: #a67c52;
    color: white;
}

/* Section Title */
.section-title {
    text-align: center;
    margin-bottom: 50px;
    position: relative;
}

.section-title h2 {
    font-size: 32px;
    font-weight: 400;
    letter-spacing: 3px;
    color: #222;
    display: inline-block;
    padding: 0 20px;
    background-color: #f8f8f8;
    position: relative;
    z-index: 1;
}

.section-title::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    height: 1px;
    background-color: #ddd;
    z-index: 0;
}

/* Header Styles */
header {
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 100;
    border-bottom: 1px solid rgba(166, 124, 82, 0.2);
}


.header-top {
    background-color: #1a1a1a;
    color: #fff;
    text-align: center;
    padding: 8px 0;
    font-size: 12px;
    letter-spacing: 1px;
}

.header-inner {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 25px 0;
}

.logo-container {
    display: flex;
    align-items: center;
}

.logo {
    font-size: 26px;
    font-weight: 400;
    letter-spacing: 0.25em;
    color: #111;
    text-decoration: none;
    position: relative;
}

.logo::after {
    content: '';
    position: absolute;
    bottom: -6px;
    left: 0;
    width: 40px;
    height: 1px;
    background-color: #a67c52;
}

.logo-tagline {
    display: block;
    font-size: 12px;
    color: #999;
    letter-spacing: 3px;
    margin-top: 5px;
}

nav {
    display: flex;
    align-items: center;
}

.nav-links {
    display: flex;
    list-style: none;
}

.nav-links li {
    margin-right: 35px;
    position: relative;
}

.nav-links a {
    text-decoration: none;
    color: #333;
    font-size: 14px;
    letter-spacing: 2px;
    text-transform: uppercase;
    transition: color 0.3s ease;
    display: inline-block;
    padding: 5px 0;
}

.nav-links a::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 0;
    height: 1px;
    background-color: #a67c52;
    transition: width 0.3s ease;
}

.nav-links a:hover {
    color: #a67c52;
}

.nav-links a:hover::after {
    width: 100%;
}

.cart-button {
    background-color: transparent;
    color: #333;
    border: 1px solid #a67c52;
    padding: 10px 22px;
    font-size: 13px;
    letter-spacing: 1px;
    text-transform: uppercase;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    cursor: pointer;
}

.cart-button:hover {
    background-color: #a67c52;
    color: white;
}

.cart-icon {
    margin-right: 8px;
    font-size: 16px;
}

/* Page Banner */
.page-banner {
    height: 40vh;
    background-image: url('/api/placeholder/1200/400');
    background-size: cover;
    background-position: center;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: white;
    position: relative;
    margin-top: 110px;
}

.page-banner::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.page-title {
    position: relative;
    z-index: 1;
    font-size: 48px;
    font-weight: 400;
    letter-spacing: 5px;
}

/* Cart Section */
.container.my-3 {
    margin-top: 150px;
    width: 100%;
}

.cart-top {
    text-align: center;
    margin: 0 auto;
    padding: 25px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}

.cart-top-text {
    color: black;
}
</style>
    <body>  
        <!--Header-->
            <header>
        <div class="header-top">
            Free shipping on all orders over $150
        </div>
        <div class="container">
            <div class="header-inner">
                <div class="logo-container">
                    <a href="index.html" class="logo">
                        LUXE ESSENCE
                        <span class="logo-tagline">PARFUMERIE</span>
                    </a>
                </div>
                <nav>
                    <ul class="nav-links">
                        <li><a href="index.html">Home</a></li>
                        <li><a href="collections.html">Collections</a></li>
                        <li><a href="bestsellers.html">Bestsellers</a></li>
                        <li><a href="about.html">About Us</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
                    <button class="cart-button">
                        <span class="cart-icon">&#10084;</span>
                        Cart (0)
                    </button>
                </nav>
            </div>
        </div>
    </header>
        
      

  <div class="container my-3">
      <div class="cart-top"><h3 class="cart-top-text">Total Price:  </h3> <a class="btn btn-primary btn-sm" href="cart-check-out">Check Out</a></div>
		<table class="table table-light" style="width: 100%; border-collapse: collapse;">
    <thead>
        <tr style="border-bottom: 1px solid #ddd;">
            <th>Name</th>
            <th>Price</th>
            <th style="text-align: center;">Quantity</th>
            <th style="text-align: center;">Action</th>
            <th>Remove</th>
        </tr>
    </thead>
    <tbody>
        <tr style="border-bottom: 1px solid #eee;">
            <td>Product Name</td>
            <td>$29.99</td>
            <td style="text-align: center;">
                <div class="form-group d-flex justify-content-center align-items-center" style="gap: 10px;">
                    <a class="btn btn-sm btn-incre" href="quantity-inc-dec?action=inc&id=id">
                        <i class="fas fa-plus-square"></i>
                    </a> 
                    <input type="text" name="quantity" class="form-control" value="1" readonly style="width: 50px; text-align: center;"> 
                    <a class="btn btn-sm btn-decre" href="quantity-inc-dec?action=dec&id=id">
                        <i class="fas fa-minus-square"></i>
                    </a>
                </div>
            </td>
            <td style="text-align: center;">
                <form action="order-now" method="post">
                    <input type="hidden" name="id" value="id">
                    <button type="submit" class="btn btn-primary btn-sm">Buy</button>
                </form>
            </td>
            <td>
                <a href="remove-from-cart?id=id" class="btn btn-sm btn-danger">Remove</a>
            </td>
        </tr>
    </tbody>
</table>
	</div>

</body>
</html>

