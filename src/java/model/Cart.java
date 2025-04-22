package model;  

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "cart") 
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto-generated primary key
    private Long id;

    
    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CartItem> items = new ArrayList<>();  

    
    
    
   

    // id
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    
    
    // items
    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }
    
    

    // totalPrice
    
    private double totalPrice;
    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
    //  calculate 
    public void calculateTotalPrice() {
        double sum = 0;
        for (CartItem item : items) {
            sum += item.getTotalPrice();  // Assuming CartItem has a method getTotalPrice()
        }
        this.totalPrice = sum;
    }

    // Method to add a CartItem to the cart (optional)
    public void addItem(CartItem item) {
        items.add(item);
        calculateTotalPrice();  // Recalculate the total price after adding an item
    }

    // Method to remove a CartItem from the cart (optional)
    public void removeItem(CartItem item) {
        items.remove(item);
        calculateTotalPrice();  // Recalculate the total price after removing an item
    }
}
