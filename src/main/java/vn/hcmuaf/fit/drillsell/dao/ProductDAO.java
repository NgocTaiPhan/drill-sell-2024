package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.model.ProductCategorys;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.ArrayList;
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

    public void removeProduct(int pId) {
        DbConnector.me().get().useHandle(handle -> {
            handle.createUpdate("UPDATE products SET productStatus = 2 WHERE productId =:productId")
                    .bind("productId", pId)
                    .execute();
        });
    }

    //Hàm sẽ thay đổi trạng thái sản phẩm trong db productStatus: 0 - Bình thường, 1 - Đã xóa, 2 - Ẩn, dựa trên id sản phẩm
    public void changProductStatus(int productId, int status) {
        DbConnector.me().get().useHandle(dbConnection -> {
            dbConnection.createUpdate("UPDATE products SET productStatus = :productStatus WHERE productId = :productId")
                    .bind("productStatus", status)
                    .bind("productId", productId)
                    .execute();
            System.out.println("Sản phẩm " + productId + " thay đổi trạng thái thành : " + status);
        });
    }

    public void addProduct(Products product) {
        DbConnector.me().get().useHandle(handle -> {
            handle.createUpdate("INSERT INTO products ( image, productName, unitPrice, categoryId, nameProducer, describle, specifions) " +
                            "VALUES (:image, :productName, :unitPrice, :categoryId, :nameProducer, :describle, :specifions)")

                    .bind("image", product.getImage())
                    .bind("productName", product.getProductName())
                    .bind("unitPrice", product.getUnitPrice())
                    .bind("categoryId", product.getCategoryId())
                    .bind("nameProducer", product.getNameProducer())
                    .bind("describle", product.getDescrible())
                    .bind("specifions", product.getSpecifions())
                    .execute();
            System.out.println("Đã thêm:  " + product);
        });
    }

    //Lấy tất cả sản phẩm hiển thị cho người dùng với productStatus = 0 -Bình thường
    public List<Products> showProd() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products WHERE productStatus = 0")
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public List<Products> getAccessory() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products WHERE categoryId IN (6, 7, 8) AND productStatus = 0 ")
                    .mapToBean(Products.class)
                    .list(); // Thay thế collect(Collectors.toList()) bằng list()
        });
    }


    public List<Products> getProductsByCategory(int categoryId) {

        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products WHERE categoryId =? AND productStatus = 0")
                    .bind(0, categoryId)
                    .mapToBean(Products.class)
                    .collect(Collectors.toList());
        });

    }

    public List<Products> getProductByProducer(String producerName) {

        return DbConnector.me().get().withHandle(handle -> {

            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products WHERE nameProducer = ? AND productStatus = 0")
                    .bind(0, producerName)
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public static List<Products> detailProduct(int productId) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery(
                            "SELECT products.productId, products.image, products.unitPrice, products.productName, products.categoryId, products.nameProducer," +
                                    "products.describle, products.specifions\n" +
                                    "FROM products " +
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
        System.out.println(ProductDAO.getInstance().getAccessory());
    }


    public List<Products> getProductsByPage(int limit, int offset) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products LIMIT :limit OFFSET :offset")
                    .bind("limit", limit)
                    .bind("offset", offset)
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public int getTotalProducts() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT COUNT(*) FROM products")
                    .mapTo(Integer.class)
                    .one();
        });
    }
}