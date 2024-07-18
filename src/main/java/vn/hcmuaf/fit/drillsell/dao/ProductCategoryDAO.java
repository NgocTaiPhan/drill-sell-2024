package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.ProductCategorys;

import java.util.List;

public class ProductCategoryDAO {
    private static ProductCategoryDAO instance;

    public ProductCategoryDAO() {
    }

    public static ProductCategoryDAO getInstance() {
        if (instance == null) {
            instance = new ProductCategoryDAO();
        }
        return instance;
    }

    public List<ProductCategorys> getAllCategory() {
        return DbConnector.me().get().withHandle(handle
                -> handle.createQuery("SELECT id , nameCategory FROM product_categorys")
                .mapToBean(ProductCategorys.class)
                .list());
    }

    public String getNameCategoryById(int categoryId) {
        return DbConnector.me().get().withHandle(handle -> handle.createQuery("SELECT nameCategory FROM product_categorys WHERE id = :categoryId")
                .bind("categoryId", categoryId)
                .mapTo(String.class)
                .findOne()
                .orElse(null));
    }
}
