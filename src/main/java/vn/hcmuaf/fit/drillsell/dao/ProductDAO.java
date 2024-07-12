package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Products;

import java.util.List;
import java.util.Set;
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


    //Hàm sẽ thay đổi trạng thái sản phẩm trong db productStatus: 0 - Bình thường, 1 - Đã xóa, 2 - Ẩn, dựa trên id sản phẩm
    public void changeProductStatus(int productId, int status) {
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


    public List<Products> getAllProds(int productStatus) {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE  productStatus = :productStatus")
                        .bind("productStatus", productStatus)
                        .mapToBean(Products.class)
                        .list());
    }


    public List<Products> getProductByProducer(String producerName, int productStatus) {
        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products " +
                            "WHERE nameProducer = :producerName AND productStatus = :productStatus")
                    .bind("productStatus", productStatus)
                    .bind("producerName", producerName)
                    .mapToBean(Products.class)
                    .list();
        });
    }

    public Products getProdById(int productId) {
        return DbConnector.me().get().withHandle(handle -> {
            String sql = "SELECT productId, image, unitPrice, productName, categoryId, nameProducer, describle, specifions " +
                    "FROM products WHERE productId = :productId";
            return handle.createQuery(sql)
                    .bind("productId", productId)
                    .mapToBean(Products.class)
                    .findOne().orElse(null);
        });
    }
    public Products getProductByName(String productName) {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE productName = :productName")
                        .bind("productName", productName)
                        .mapToBean(Products.class)
                        .findOnly()
        );
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



    public void updateProd(Products product) {

        DbConnector.me().get().withHandle(handle -> handle.createUpdate(" UPDATE products\n" +
                        "        SET image = :image,\n" +
                        "            productName = :productName,\n" +
                        "            unitPrice = :unitPrice,\n" +
                        "            categoryId = :categoryId,\n" +
                        "            nameProducer = :nameProducer,\n" +
                        "            describle = :describle,\n" +
                        "            specifions = :specifions\n" +
                        "        WHERE productId = :productId")
                .bindBean(product)
                .execute());
        System.out.println("update: " + product.getProductId());
    }


    public void addProdFormExcel(List<Products> prods) {
        DbConnector.me().get().useHandle(handle -> {
            for (Products prod : prods) {
                handle.createUpdate(
                                "INSERT INTO products (image, productName, unitPrice, categoryId, nameProducer, describle, specifions) \" +\n" +
                                        "                        \"VALUES (:image, :productName, :unitPrice, :categoryId, :nameProducer, :describle, :specifions)")
                        .bindBean(prods)
                        .execute();
            }
        });
    }

    //    Lấy sản phẩm bằng categoryId
    public List<Products> getProductByCategory(Set<Integer> categoryIds, int productStatus) {
        String categoryIdString = categoryIds.stream()
                .map(String::valueOf)
                .collect(Collectors.joining(","));


        return DbConnector.me().get().withHandle(handle -> {
            return handle.createQuery("SELECT productId, image, productName, unitPrice FROM products " +
                            "WHERE categoryId IN (" + categoryIdString + ") AND productStatus = :productStatus")
                    .bind("productStatus", productStatus)
                    .mapToBean(Products.class)
                    .list();
        });
    }

}
