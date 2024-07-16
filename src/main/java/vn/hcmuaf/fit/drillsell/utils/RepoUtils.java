package vn.hcmuaf.fit.drillsell.utils;

import vn.hcmuaf.fit.drillsell.dao.repo.RepoDAO;

import java.util.List;
import java.util.Map;

public class RepoUtils {
    public static List<Map<String, Object>> getRepo() {
        return RepoDAO.getInstance().getRepo();
    }

    public static void addQuantity(int productId, int quantity, int userId) {
        RepoDAO.getInstance().addQuantity(productId, quantity, userId);
    }

    public static int getAllQuantityFromRepoByProductId(int productId) {
        return RepoDAO.getInstance().getAllQuantityFromRepoByProductId(productId);
    }
}
