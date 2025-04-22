package com.example.controller;

import model.Cart;
import model.CartItem;
import model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CartController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Sample data, ideally you would retrieve this from the database.
        Cart cart = new Cart();

        // Example Products
        Product product1 = new Product();
        product1.setId(1L);
        product1.setName("Laptop");
        product1.setPrice(1000.0);

        Product product2 = new Product();
        product2.setId(2L);
        product2.setName("Smartphone");
        product2.setPrice(500.0);

        // CartItems
        CartItem cartItem1 = new CartItem();
        cartItem1.setProduct(product1);
        cartItem1.setQuantity(1);

        CartItem cartItem2 = new CartItem();
        cartItem2.setProduct(product2);
        cartItem2.setQuantity(2);

        // Adding items to the cart
        cart.addItem(cartItem1);
        cart.addItem(cartItem2);

        // Setting the cart in the request scope to display it in JSP
        request.setAttribute("cart", cart);

        // Forwarding the request to the cart.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/cart.jsp");
        dispatcher.forward(request, response);
    }
}
