package vn.hcmuaf.fit.drillsell.utils;

import vn.hcmuaf.fit.drillsell.dao.OrderDAO;
import vn.hcmuaf.fit.drillsell.dao.repo.RepoDAO;

import java.util.List;
import java.util.Map;

public class RepoUtils {
    public static List<Map<String, Object>> getRepo() {
        List<Map<String, Object>> repoValue = RepoDAO.getInstance().getRepo();
        for (Map<String, Object> repoMap : repoValue) {
            int productId = (int) repoMap.get("productId");
            RepoDAO.getInstance().updateImportQuantityByProductId(productId, getAllQuantityFromRepoByProductId(productId));
            int importQuantity = (int) repoMap.get("importQuantity");
        }
        return repoValue;

    }

    public static void addQuantity(int productId, int quantity, int userId) {
        RepoDAO.getInstance().addQuantity(productId, quantity, userId);
    }

    public static int getAllQuantityFromRepoByProductId(int productId) {
        return RepoDAO.getInstance().getAllQuantityFromRepoByProductId(productId);
    }

    public static void main(String[] args) {
        System.out.println(getAllQuantityFromRepoByProductId(2));
    }
}
