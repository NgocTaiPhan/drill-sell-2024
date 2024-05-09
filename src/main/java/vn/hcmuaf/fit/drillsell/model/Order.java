package vn.hcmuaf.fit.drillsell.model;

import org.jetbrains.annotations.Nullable;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int cartId;
    private int userId;
    private int productId;
    private String stauss;
    @Nullable
    private Timestamp timeOrder;
    private String phone;
    private String nameCustom;
    private String address;
    private String productName;
    private double totalPrice;
    private int quantity;
    public Order() {
    }

    public Order(int id, int cartId, int userId, int productId, String stauss, @Nullable Timestamp timeOrder, String phone, String nameCustom, String address, String productName, double totalPrice, int quantity) {
        this.id = id;
        this.cartId = cartId;
        this.userId = userId;
        this.productId = productId;
        this.stauss = stauss;
        this.timeOrder = timeOrder;
        this.phone = phone;
        this.nameCustom = nameCustom;
        this.address = address;
        this.productName = productName;
        this.totalPrice = totalPrice;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getStauss() {
        return stauss;
    }

    public void setStauss(String stauss) {
        this.stauss = stauss;
    }

    public Timestamp getTimeOrder() {
        return timeOrder;
    }

    public void setTimeOrder(Timestamp timeOrder) {
        this.timeOrder = timeOrder;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNameCustom() {
        return nameCustom;
    }

    public void setNameCustom(String nameCustom) {
        this.nameCustom = nameCustom;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
        return "Order{" +
                "id=" + id +
                ", cartId=" + cartId +
                ", userId=" + userId +
                ", productId=" + productId +
                ", stauss='" + stauss + '\'' +
                ", timeOrder=" + timeOrder +
                ", phone='" + phone + '\'' +
                ", nameCustom='" + nameCustom + '\'' +
                ", address='" + address + '\'' +
                ", productName='" + productName + '\'' +
                ", totalPrice=" + totalPrice +
                ", quantity=" + quantity +
                '}';
    }
}
