package model;

import java.io.Serializable;

public class CartItemTest implements Serializable {
    private ProductTest product;
    private int quantity;

    // Constructors
    public CartItemTest() {}

    public CartItemTest(ProductTest product, int quantity) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than 0");
        }
        this.product = product;
        this.quantity = quantity;
    }

    // Getters and Setters
    public ProductTest getProduct() {
        return product;
    }

    public void setProduct(ProductTest product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than 0");
        }
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        if (product != null) {
            return this.quantity * product.getPrice();
        }
        return 0.0;
    }

    @Override
    public String toString() {
        return String.format("CartItem{product='%s', quantity=%d, totalPrice=%.2f}",
                             product != null ? product.getName() : "No Product", quantity, getTotalPrice());
    }
}
