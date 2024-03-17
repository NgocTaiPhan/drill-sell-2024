package vn.hcmuaf.fit.drillsell.bean;
//chỉ cho 1 sp duy nhất
public class Product {
    private int productId;
    private String image, productName;
    private double unitPrice;

    private int producerId, categoryId;

    private int boxsell;

    public Product() {
    }

    public Product(int productId, String image, String productName, double unitPrice) {
        this.productId = productId;
        this.image = image;
        this.productName = productName;
        this.unitPrice = unitPrice;
    }

    public Product(int productId, String image, String productName, double unitPrice, int producerId, int categoryId) {
        this.productId = productId;
        this.image = image;
        this.productName = productName;
        this.unitPrice = unitPrice;
        this.producerId = producerId;
        this.categoryId = categoryId;
    }

    public int getProducerId() {
        return producerId;
    }

    public void setProducerId(int producerId) {
        this.producerId = producerId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    public int getboxsell() {
        return boxsell;
    }

    public void setboxsell(int boxsell) {
        this.boxsell = boxsell;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", image='" + image + '\'' +
                ", productName='" + productName + '\'' +
                ", unitPrice=" + unitPrice +
                ", producerId=" + producerId +
                ", categoryId=" + categoryId +

                '}';
    }
}
