package vn.hcmuaf.fit.drillsell.bean;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;

    public Cart() {
        this.items = new ArrayList<>();
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    // Thêm một sản phẩm vào giỏ hàng
    public void addItem(CartItem item) {
        items.add(item);
    }

    // Xóa một sản phẩm khỏi giỏ hàng
    public void removeItem(int productId) {
        items.removeIf(item -> item.getProductId() == productId);
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng
    public void updateItemQuantityLow(int productId) {
        for (CartItem item : items) {
            int quantity = item.getQuantity();
            if (item.getProductId() == productId) {
                quantity = quantity -1;
                item.setQuantity(quantity);
                return;
            }
        }
    }
    public void updateItemQuantitHigh(int productId) {
        for (CartItem item : items) {
            int quantity = item.getQuantity();
            if (item.getProductId() == productId) {
                quantity = quantity +1;
                item.setQuantity(quantity);
                return;
            }
        }
    }



    // Tính tổng giá tiền của tất cả các sản phẩm trong giỏ hàng
    public double calculateTotalPrice() {
        double totalPrice = 0;
        for (CartItem item : items) {
            totalPrice += item.getUnitPrice() * item.getQuantity();
        }
        return totalPrice;
    }

        public static void main(String[] args) {
            // Tạo một giỏ hàng mới
            Cart cart = new Cart();
            // Thêm các sản phẩm vào giỏ hàng
           CartItem item1 = new CartItem(1, 4, 3000, 1, "kkk", "hoa", 1000);
            CartItem item2 = new CartItem(1, 4, 3000, 1, "kkk", "jjjieu", 1000);

            cart.addItem(item1);
            cart.addItem(item2);

            // In ra thông tin giỏ hàng
            System.out.println("Cart items:");
            for (CartItem item : cart.getItems()) {
                System.out.println(item.getProductName() + " - Quantity: " + item.getQuantity() + " - Unit Price: $" + item.getUnitPrice());
            }

            // Tính tổng giá tiền của giỏ hàng
            System.out.println("Total price: $" + cart.calculateTotalPrice());

            // Cập nhật số lượng của một sản phẩm trong giỏ hàng
            cart.updateItemQuantitHigh(1);

            // In ra thông tin giỏ hàng sau khi cập nhật
            System.out.println("Updated cart items:");
            for (CartItem item : cart.getItems()) {
                System.out.println(item.getProductName() + " - Quantity: " + item.getQuantity() + " - Unit Price: $" + item.getUnitPrice());
            }

            // Tính tổng giá tiền của giỏ hàng sau khi cập nhật
            System.out.println("Total price after update: $" + cart.calculateTotalPrice());

            // Xóa một sản phẩm khỏi giỏ hàng
            cart.removeItem(2);

            // In ra thông tin giỏ hàng sau khi xóa
            System.out.println("Cart items after removal:");
            for (CartItem item : cart.getItems()) {
                System.out.println(item.getProductName() + " - Quantity: " + item.getQuantity() + " - Unit Price: $" + item.getUnitPrice());
            }

            // Tính tổng giá tiền của giỏ hàng sau khi xóa
            System.out.println("Total price after removal: $" + cart.calculateTotalPrice());
        }
    }

