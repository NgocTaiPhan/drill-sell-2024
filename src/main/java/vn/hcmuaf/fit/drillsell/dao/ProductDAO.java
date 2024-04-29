package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.model.ProductCategorys;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

public class ProductDAO {
    private static ProductDAO instance;

    public ProductDAO() {
    }

    public static ProductDAO getInstance() {
        if (instance == null) {
            instance = new ProductDAO();
        }
        return instance;
    }

    public void addProduct(Products product) {
        DbConnector.me().get().useHandle(handle -> {
            handle.createUpdate("INSERT INTO products (image, productName, unitPrice, categoryId, nameProducer, describle, specifions) " +
                            "VALUES (:image, :productName, :unitPrice, :categoryId, :nameProducer, :describle, :specifions)")
                    .bind("image", product.getImage())
                    .bind("productName", product.getProductName())
                    .bind("unitPrice", product.getUnitPrice())
                    .bind("categoryId", product.getCategoryId())
                    .bind("nameProducer", product.getNameProducer())
                    .bind("describle", product.getDescrible())
                    .bind("specifions", product.getSpecifions())
                    .execute();
        });
    }

    public List<Products> showProd() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products ORDER BY RAND()")
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public List<Products> getAccessory() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("\n" +
                            "SELECT productId, image, productName, unitPrice  \n" +
                            "FROM products " + // Thêm khoảng trắng sau "products"
                            "WHERE categoryId IN (6, 7, 8) ORDER BY RAND()")
                    .mapToBean(Products.class)
                    .list(); // Thay thế collect(Collectors.toList()) bằng list()
        });
    }


    public static List<Products> getProductsByCategory(int categoryId) {

        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products WHERE categoryId =? LIMIT 12;")
                    .bind(0, categoryId)
                    .mapToBean(Products.class)
                    .collect(Collectors.toList());
        });

    }

    public List<Products> getProductByProducer(String producerName) {

        return DbConnector.me().get().withHandle(handle -> {

            return handle.createQuery("SELECT productId, image, productName, unitPrice " +

                            "FROM products\n" +

                            "WHERE nameProducer = ?;\n")
                    .bind(0, producerName)
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public static List<Products> detailProduct(int productId) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery(
                            "SELECT products.productId, products.image, products.unitPrice, products.productName, products.categoryId, products.nameProducer, repo.importQuantity, \n" +
                                    "products.describle, products.specifions\n" +
                                    "FROM products JOIN repo ON products.productId = repo.productId\n" +
                                    "WHERE products.productId = :productId\n")
                    .bind("productId", productId)
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public String getFormattedUnitPrice(Products product) {
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return currencyFormat.format(product.getUnitPrice() * 1000);
    }

    public List<String> getAllProducers() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT DISTINCT nameProducer FROM products")
                    .mapTo(String.class)
                    .list();
        });
    }


    public List<ProductCategorys> getAllCategory() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT id , nameCategory FROM product_categorys")
                    .mapToBean(ProductCategorys.class)
                    .list();
        });
    }


    public String getNameCategoryById(int categoryId) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT nameCategory FROM product_categorys WHERE id = :categoryId")
                    .bind("categoryId", categoryId)
                    .mapTo(String.class)
                    .findOne()
                    .orElse(null);
        });
    }

    public List<Products> showProductsLimited(int limit) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery(
                            "SELECT productId, image, productName, unitPrice FROM products ORDER BY RAND() LIMIT :limit")
                    .bind("limit", limit)
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public static void main(String[] args) {
        String url = "https://scontent.fhan14-5.fna.fbcdn.net/v/t39.30808-6/440126657_398456923091637_5853396435464547150_n.jpg?stp=dst-jpg_p526x296&_nc_cat=1&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEJJRUZlrzZOSXBwpolFqLJk5m_P8h9lEGTmb8_yH2UQW-hYaoz7xhnW2Q1dT5qM0ZNnsjSkGWGOB9Slt7gJLWk&_nc_ohc=c67nylOzjJYAb6ddBM8&_nc_ht=scontent.fhan14-5.fna&oh=00_AfBldLM1Tzw2OqhAHPco5tZs-LoLvOGWTe4fHfs4MZyP4w&oe=663516D5";
//        System.out.println(ProductDAO.getInstance().getNameCategoryById(4));
        ProductDAO.getInstance().addProduct(new Products(url, "Máy khoan test", 1000, 2, "test", "test", "test"));

    }


}