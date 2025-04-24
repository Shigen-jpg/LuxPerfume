package dao;

import java.sql.*;
import java.util.*;

import model.Cart;
import model.Product;

public class ProductDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public ProductDao(Connection con) {
        super();
        this.con = con;
    }

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        try {
            // Corrected query to match your actual table and column names
            query = "SELECT * FROM NBUSER.PRODUCT"; 
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));  // Fetch the correct column
                product.setName(rs.getString("pro_name"));  // Correct column name for product name
                product.setPrice(rs.getDouble("price"));  // Correct column name for product price

                productList.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return productList;
    }

    public Product getSingleProduct(int id) {
        Product product = null;
        try {
            // Correct query for fetching a single product by ID
            query = "SELECT * FROM NBUSER.PRODUCT WHERE id = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();

            while (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("pro_name"));
                product.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return product;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double total = 0;
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    // Correct query to fetch price for each product in cart
                    query = "SELECT price FROM NBUSER.PRODUCT WHERE id = ?";
                    pst = this.con.prepareStatement(query);
                    pst.setInt(1, item.getId());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        total += rs.getDouble("price") * item.getQuantity();
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return total;
    }

//    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
//        List<Cart> cartProductList = new ArrayList<>();
//        try {
//            if (cartList.size() > 0) {
//                for (Cart item : cartList) {
//                    // Correct query to fetch product data for each item in the cart
//                    query = "SELECT * FROM NBUSER.PRODUCT WHERE id = ?";
//                    pst = this.con.prepareStatement(query);
//                    pst.setInt(1, item.getId());
//                    rs = pst.executeQuery();
//                    while (rs.next()) {
//                        Cart cartItem = new Cart();
//                        cartItem.setId(rs.getInt("id"));
//                        cartItem.setName(rs.getString("pro_name"));
//                        cartItem.setPrice(rs.getDouble("price") * item.getQuantity());
//                        cartItem.setQuantity(item.getQuantity());
//                        cartProductList.add(cartItem);
//                    }
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            System.out.println(e.getMessage());
//        }
//        return cartProductList;
//    }
}
