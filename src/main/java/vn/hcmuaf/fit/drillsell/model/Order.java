package vn.hcmuaf.fit.drillsell.model;

import org.jetbrains.annotations.Nullable;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private int numberOfOrders, quantityProduct;
    private double sumTotalDay;
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

    public Order(int orderId, int userId, int numberOfOrders, int quantityProduct, int sumTotalDay, String nameCustomer, String phone, String address, String stauss, double shippingFee, List<OrderItem> orderItems) {
        this.orderId = orderId;
        this.userId = userId;
        this.numberOfOrders = numberOfOrders;
        this.quantityProduct = quantityProduct;
        this.sumTotalDay = sumTotalDay;
        this.nameCustomer = nameCustomer;
        this.phone = phone;
        this.address = address;
        this.stauss = stauss;
        this.shippingFee = shippingFee;
        this.orderItems = orderItems;
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

    public int getNumberOfOrders() {
        return numberOfOrders;
    }

    public void setNumberOfOrders(int numberOfOrders) {
        this.numberOfOrders = numberOfOrders;
    }

    public int getQuantityProduct() {
        return quantityProduct;
    }

    public void setQuantityProduct(int quantityProduct) {
        this.quantityProduct = quantityProduct;
    }

    public double getSumTotalDay() {
        return sumTotalDay;
    }

    public void setSumTotalDay(double sumTotalDay) {
        this.sumTotalDay = sumTotalDay;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", NumberOfOrders=" + numberOfOrders +
                ", quantityProduct=" + quantityProduct +
                ", sumTotalDay=" + sumTotalDay +
                ", nameCustomer='" + nameCustomer + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", stauss='" + stauss + '\'' +
                ", shippingFee=" + shippingFee +
                ", orderItems=" + orderItems +
                '}';
    }
}
