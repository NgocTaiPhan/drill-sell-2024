package vn.hcmuaf.fit.drillsell.model;


import java.sql.Date;

public class Products {
    private int productId;
    private String image;
    private String productName;
    private double unitPrice;
    private int categoryId;
    private String nameProducer;
    private String describle;
    private String specifions;

    public Products() {
    }

    public Products(String image, String productName, double unitPrice, int categoryId, String nameProducer, String describle, String specifions) {
        this.image = image;
        this.productName = productName;
        this.unitPrice = unitPrice;
        this.categoryId = categoryId;
        this.nameProducer = nameProducer;
        this.describle = describle;
        this.specifions = specifions;
    }

    public Products(int productId, String image, String productName, double unitPrice, int categoryId, String nameProducer, String describle, String specifions) {
        this.productId = productId;
        this.image = image;
        this.productName = productName;
        this.unitPrice = unitPrice;
        this.categoryId = categoryId;
        this.nameProducer = nameProducer;
        this.describle = describle;
        this.specifions = specifions;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getNameProducer() {
        return nameProducer;
    }

    public void setNameProducer(String nameProducer) {
        this.nameProducer = nameProducer;
    }

    public String getDescrible() {
        return describle;
    }

    public void setDescrible(String describle) {
        this.describle = describle;
    }

    public String getSpecifions() {
        return specifions;
    }

    public void setSpecifions(String specifions) {
        this.specifions = specifions;
    }
}