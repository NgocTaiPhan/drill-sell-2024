package vn.hcmuaf.fit.drillsell.model;

import org.jetbrains.annotations.Nullable;

import java.sql.Date;
import java.sql.Timestamp;

public class OrderItem {
    private int orderId;
    private int productId;
    private int cartId, idItem;
    @Nullable
    private Date expectedDate;

    private double unitPrice;
    private String productName;
    private double totalPrice;
    private int quantity;

    public OrderItem() {
    }

    public OrderItem(int orderId, int productId, int cartId, int idItem, Date expectedDate, double unitPrice, String productName, double totalPrice, int quantity) {
        this.orderId = orderId;
        this.productId = productId;
        this.cartId = cartId;
        this.idItem = idItem;
        this.expectedDate = expectedDate;
        this.unitPrice = unitPrice;
        this.productName = productName;
        this.totalPrice = totalPrice;
        this.quantity = quantity;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getIdItem() {
        return idItem;
    }

    public void setIdItem(int idItem) {
        this.idItem = idItem;
    }

    public Date getExpectedDate() {
        return expectedDate;
    }

    public void setExpectedDate(Date expectedDate) {
        this.expectedDate = expectedDate;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderId=" + orderId +
                ", productId=" + productId +
                ", cartId=" + cartId +
                ", idItem=" + idItem +
                ", expectedDate=" + expectedDate +
                ", unitPrice=" + unitPrice +
                ", productName='" + productName + '\'' +
                ", totalPrice=" + totalPrice +
                ", quantity=" + quantity +
                '}';
    }
}
