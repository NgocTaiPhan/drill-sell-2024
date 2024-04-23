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

    public static void main(String[] args) {

        System.out.println(ProductDAO.getInstance().getNameCategoryById(4));

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
}