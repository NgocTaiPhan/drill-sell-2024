package vn.hcmuaf.fit.drillsell.model;

import java.util.Date;
import java.util.List;

public class Order {
    private int orderId, revenue;
    private int userId, year, month;
    private int numberOfOrders, quantityProduct;
    private double sumTotalDay, sumTotal;
    private String nameCustomer;
    private String phone;
    private String address;
    private String stauss;
    private double shippingFee;
    private Date expectedDate;

    private List<OrderItem> orderItems;

    public Order() {
    }

    public Order(int userId, String nameCustomer, String phone, String address) {
        this.userId = userId;
        this.nameCustomer = nameCustomer;
        this.phone = phone;
        this.address = address;
    }

    public Order(int orderId, int revenue, int userId, int year, int month, int numberOfOrders, int quantityProduct, double sumTotalDay, double sumTotal, String nameCustomer, String phone, String address, String stauss, double shippingFee, Date expectedDate, List<OrderItem> orderItems) {
        this.orderId = orderId;
        this.revenue = revenue;
        this.userId = userId;
        this.year = year;
        this.month = month;
        this.numberOfOrders = numberOfOrders;
        this.quantityProduct = quantityProduct;
        this.sumTotalDay = sumTotalDay;
        this.sumTotal = sumTotal;
        this.nameCustomer = nameCustomer;
        this.phone = phone;
        this.address = address;
        this.stauss = stauss;
        this.shippingFee = shippingFee;
        this.expectedDate = expectedDate;
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

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public double getSumTotal() {
        return sumTotal;
    }

    public void setSumTotal(double sumTotal) {
        this.sumTotal = sumTotal;
    }

    public int getRevenue() {
        return revenue;
    }

    public void setRevenue(int revenue) {
        this.revenue = revenue;
    }

    public Date getExpectedDate() {
        return expectedDate;
    }

    public void setExpectedDate(Date expectedDate) {
        this.expectedDate = expectedDate;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", revenue=" + revenue +
                ", userId=" + userId +
                ", year=" + year +
                ", month=" + month +
                ", numberOfOrders=" + numberOfOrders +
                ", quantityProduct=" + quantityProduct +
                ", sumTotalDay=" + sumTotalDay +
                ", sumTotal=" + sumTotal +
                ", nameCustomer='" + nameCustomer + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", stauss='" + stauss + '\'' +
                ", shippingFee=" + shippingFee +
                ", expectedDate=" + expectedDate +
                ", orderItems=" + orderItems +
                '}';
    }
}
