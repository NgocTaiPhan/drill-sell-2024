package vn.hcmuaf.fit.drillsell.model;

import org.jetbrains.annotations.Nullable;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private String nameCustomer;
    private String phone;
    private String address;
    private String stauss;
    private double shippingFee;
    private List<OrderItem> orderItems;

    public Order() {
    }

    public Order(int userId, String nameCustomer, String phone, String address) {
        this.userId = userId;
        this.nameCustomer = nameCustomer;
        this.phone = phone;
        this.address = address;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getNameCustomer() {
        return nameCustomer;
    }

    public void setNameCustomer(String nameCustomer) {
        this.nameCustomer = nameCustomer;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStauss() {
        return stauss;
    }

    public void setStauss(String stauss) {
        this.stauss = stauss;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", nameCustomer='" + nameCustomer + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", stauss='" + stauss + '\'' +
                ", shippingFee=" + shippingFee +
                ", orderItems=" + orderItems +
                '}';
    }


}
