package vn.hcmuaf.fit.drillsell.model;

public class CheckOut {
    private int productId, userId;
    private String productName;
    private double unitPrice;
    private int quantity;

    private double totalPrice;
    private double sumTotalPrice;

    private String nameAndPhone;
    private String address;

    public CheckOut() {
    }

    public CheckOut(int productId, int userId, String productName, double unitPrice, int quantity, double totalPrice, double sumTotalPrice, String nameAndPhone, String address) {
        this.productId = productId;
        this.userId = userId;
        this.productName = productName;
        this.unitPrice = unitPrice;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.sumTotalPrice = sumTotalPrice;
        this.nameAndPhone = nameAndPhone;
        this.address = address;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public double getSumTotalPrice() {
        return sumTotalPrice;
    }

    public void setSumTotalPrice(double sumTotalPrice) {
        this.sumTotalPrice = sumTotalPrice;
    }

    public String getNameAndPhone() {
        return nameAndPhone;
    }

    public void setNameAndPhone(String nameAndPhone) {
        this.nameAndPhone = nameAndPhone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "CheckOut{" +
                "productId=" + productId +
                ", userId=" + userId +
                ", productName='" + productName + '\'' +
                ", unitPrice=" + unitPrice +
                ", quantity=" + quantity +
                ", totalPrice=" + totalPrice +
                ", sumTotalPrice=" + sumTotalPrice +
                ", nameAndPhone='" + nameAndPhone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
