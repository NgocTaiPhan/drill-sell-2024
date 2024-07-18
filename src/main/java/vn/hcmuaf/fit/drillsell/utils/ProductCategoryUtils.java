package vn.hcmuaf.fit.drillsell.utils;

import vn.hcmuaf.fit.drillsell.dao.ProductCategoryDAO;
import vn.hcmuaf.fit.drillsell.model.ProductCategorys;

import java.util.List;

public class ProductCategoryUtils {
    public static List<ProductCategorys> getAllCategory() {
        return ProductCategoryDAO.getInstance().getAllCategory();
    }

    public static String getNameCategoryById(int categoryId) {
        return ProductCategoryDAO.getInstance().getNameCategoryById(categoryId);
    }
}
