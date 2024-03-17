package vn.hcmuaf.fit.drillsell.bean;


import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

public class Products {
    private int productId;
    private String image;
    private String productName;
    private double unitPrice;
    private int categoryId;
    private String nameProducer;
    private int statuss;
    private String describle;
    private Date dateAdd;
    private String specifions;

    public Products(int productId, String image, String productName, double unitPrice, int categoryId, String nameProducer, int statuss, String describle, Date dateAdd, String specifions) {

        this.productId = productId;
        this.image = image;
        this.productName = productName;
        this.unitPrice = unitPrice;
        this.categoryId = categoryId;
        this.nameProducer = nameProducer;
        this.statuss = statuss;
        this.describle = describle;
        this.dateAdd = dateAdd;
        this.specifions = specifions;
    }

    public Products() {
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

    public int getStatuss() {
        return statuss;
    }

    public void setStatuss(int statuss) {
        this.statuss = statuss;
    }

    public String getDescrible() {
        return describle;
    }

    public void setDescrible(String describle) {
        this.describle = describle;
    }

    public Date getDateAdd() {
        return dateAdd;
    }

    public void setDateAdd(Date dateAdd) {
        this.dateAdd = dateAdd;
    }

    public String getSpecifions() {
        return specifions;
    }

    public void setSpecifions(String specifions) {
        this.specifions = specifions;
    }

    @Override
    public String toString() {
        return "Products{" +
                "productId=" + productId +
                ", image='" + image + '\'' +
                ", productName='" + productName + '\'' +
                ", unitPrice=" + unitPrice +
                ", categoryId=" + categoryId +
                ", nameProducer='" + nameProducer + '\'' +
                ", statuss=" + statuss +
                ", describle='" + describle + '\'' +
                ", dateAdd=" + dateAdd +
                ", specifions='" + specifions + '\'' +
                '}';
    }
}
