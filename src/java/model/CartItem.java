//package model;
//
//import javax.persistence.*;
//
//@Entity
//public class CartItem {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    @ManyToOne
//    @JoinColumn(name = "cart_id")
//    private Cart cart;
//
//    @ManyToOne
//    @JoinColumn(name = "product_id")
//    private Product product;
//
//    private int quantity;
//
//    // Getter and Setter methods
//    public Long getId() {
//        return id;
//    }
//
//    public void setId(Long id) {
//        this.id = id;
//    }
//
//    public Cart getCart() {
//        return cart;
//    }
//
//    public void setCart(Cart cart) {
//        this.cart = cart;
//    }
//
//    public Product getProduct() {
//        return product;
//    }
//
//    public void setProduct(Product product) {
//        this.product = product;
//    }
//
//    public int getQuantity() {
//        return quantity;
//    }
//
//    public void setQuantity(int quantity) {
//        if (quantity > 0) { // Ensure positive quantity
//            this.quantity = quantity;
//        } else {
//            throw new IllegalArgumentException("Quantity must be greater than 0");
//        }
//    }
//
//    // Calculate total price of this CartItem
//    public double getTotalPrice() {
//        return product.getPrice() * quantity;
//    }
//
//    // Override hashCode and equals for proper comparison and use in collections
//    @Override
//    public int hashCode() {
//        int hash = 0;
//        hash += (id != null ? id.hashCode() : 0);
//        return hash;
//    }
//
//    @Override
//    public boolean equals(Object object) {
//        if (!(object instanceof CartItem)) {
//            return false;
//        }
//        CartItem other = (CartItem) object;
//        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
//            return false;
//        }
//        return true;
//    }
//
//    @Override
//    public String toString() {
//        return "model.CartItem[ id=" + id + " ]";
//    }
//}
