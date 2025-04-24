package model;

public class Cart extends Product {
    private int quantity;  // Number of items in the cart

    public Cart(int id, String name, Double price, int quantity) {
        super(id, name, price);  // Calling the Product constructor
        this.quantity = quantity;
    }

    // Getter and setter for quantity
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Method to calculate total price for this product (price * quantity)
    public double getTotalPrice() {
        return getPrice() * quantity;
    }

    @Override
    public String toString() {
        return "Cart [id=" + getId() + ", name=" + getName() + ", price=" + getPrice() + ", quantity=" + quantity + "]";
    }
}
