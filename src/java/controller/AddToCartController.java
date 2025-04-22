
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

package controller;


@RestController
@RequestMapping("/cart")
public class AddToCartController {

    @Autowired
    private CartController addToCart;  // Use your AddToCart service here

    @PostMapping("/add")
    public ResponseEntity<String> addProductToCart(@RequestBody Product product) {
        boolean isAdded = addToCart.addItemToCart(product.getId());

        if (isAdded) {
            return ResponseEntity.ok("Product added to cart successfully!");
        } else {
            return ResponseEntity.status(500).body("Failed to add product to cart.");
        }
    }
}
