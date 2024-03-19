package vn.hcmuaf.fit.drillsell.service;

import vn.hcmuaf.fit.drillsell.bean.Products;
import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

public class ProductService {
    private static ProductService instance;

    public ProductService() {
    }

    public static ProductService getInstance() {
        if (instance == null) {
            instance = new ProductService();
        }
        return instance;
    }

    public static   List<Products> showProd() {
            return DbConnector.me().get().withHandle(handle -> {
                return handle.createQuery("SELECT productId, image, productName, unitPrice, categoryId, nameProducer, statuss, describle, dateAdd, specifions FROM products ORDER BY RAND()")
                        .mapToBean(Products.class)
                        .list();
            });
    }

    public  List<Products> getAccessory() {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("\n" +
                            "SELECT productId, image, productName, unitPrice, categoryId, nameProducer, statuss, describle, dateAdd, specifions \n" +
                            "FROM products " + //Thêm khoảng trắng sau "products"
                            "WHERE categoryId IN (6, 7, 8) ORDER BY RAND()")
                    .mapToBean(Products.class)
                    .list(); // Thay thế collect(Collectors.toList()) bằng list()
        });
    }

    public static List<Products> getProductsByCategory(int categoryId) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice, categoryId, nameProducer, statuss, describle, dateAdd, specifions  FROM products WHERE categoryId =? LIMIT 12;")
                    .bind(0, categoryId)
                    .mapToBean(Products.class)
                    .collect(Collectors.toList());
        });

    }

    public  List<Products> getProductByProducer(String producerName) {

        return DbConnector.me().get().withHandle(handle -> {

            return handle.createQuery("SELECT productId, image, productName, unitPrice, categoryId, nameProducer, statuss, describle, dateAdd, specifions " +

                            "FROM products\n" +

                            "WHERE nameProducer = ?;\n")
                    .bind(0, producerName)
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public  List<Products> detailProduct(int productId){
        return  DbConnector.me().get().withHandle(handle -> {
            return  handle.createQuery("SELECT productId, image, productName, unitPrice, categoryId, nameProducer, statuss, describle, dateAdd, specifions " +
                            "FROM products" +
                    " WHERE productId =:productId")
                    .bind("productId", productId)
                    .mapToBean(Products.class)
                    .list();
        });
    }







    public static void main(String[] args) {
//            System.out.println(ProductService.getProductsByCategory(2));
//        System.out.println(ProductService.getAccessory());
//        getProductsByCategory(2);


    }

}