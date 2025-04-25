package model;

public class Payment {
    private String paymentMethod;
    private double totalAmount;
    private String shippingAddress;
    private String name;
    private String orderDate;
    private String orderId;

    public Payment(String paymentMethod, double totalAmount, String shippingAddress, String name) {
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.name = name;
        this.orderDate = getCurrentDate();
        this.orderId = generateOrderId();
    }

    private String getCurrentDate() {
        // Simple date format for current date (you can adjust as needed)
        return java.time.LocalDate.now().toString();
    }

    private String generateOrderId() {
        // Simple order ID generation (you can modify this logic)
        return "ORD" + System.currentTimeMillis();
    }

    public String getOrderId() {
        return orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public String getName() {
        return name;
    }
}
