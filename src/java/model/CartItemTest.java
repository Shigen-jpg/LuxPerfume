package model;
import connection.DbCon;


public class CartItemTest {
    private ProductTest product;
    private int quantity;

    // Constructors
    public CartItemTest() {}

    public CartItemTest(ProductTest product, int quantity) {
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
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return this.quantity * product.getPrice();
    }

    @Override
    public String toString() {
        return "CartItemTest{" +
               "product=" + product.getName() +
               ", quantity=" + quantity +
               ", totalPrice=" + getTotalPrice() +
               '}';
    }
}
