package vn.hcmuaf.fit.drillsell.bean;

public class ProductCategorys {
    private int id;
    private String nameCategory;

    public ProductCategorys() {
    }

    public ProductCategorys(int id, String nameCategory) {
        this.id = id;
        this.nameCategory = nameCategory;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameCategory() {
        return nameCategory;
    }

    public void setNameCategory(String nameCategory) {
        this.nameCategory = nameCategory;
    }

    @Override
    public String toString() {
        return "product_categorys{" +
                "id=" + id +
                ", nameCatrgory='" + nameCategory + '\'' +
                '}';
    }
}
