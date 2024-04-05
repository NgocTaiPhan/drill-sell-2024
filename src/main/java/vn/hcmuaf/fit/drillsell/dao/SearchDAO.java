package vn.hcmuaf.fit.drillsell.dao;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.db.DbConnector;
import java.util.List;
public class SearchDAO {
    public static List<Products> searchProductByName(String input) {
        // Sử dụng try-with-resources để đảm bảo đóng tài nguyên tự động
        try (var handle = DbConnector.me().get().open()) {
            return handle.createQuery("SELECT products.productId, image, productName, unitPrice FROM products WHERE MATCH(productName) AGAINST (:input IN NATURAL LANGUAGE MODE)  ")
                    .bind("input", "%" + input.toLowerCase() + "%") // Sử dụng bind với tên tham số để tránh SQL Injection
                    .mapToBean(Products.class)
                    .list();
        }
    }




    public static void printSearchResults(String input) {
        List<Products> results = searchProductByName(input);
        for (Products p : results) {
            System.out.println(p);
        }
    }

    public static void main(String[] args) {
        printSearchResults("máy dùng để đục bê tông");
    }
}