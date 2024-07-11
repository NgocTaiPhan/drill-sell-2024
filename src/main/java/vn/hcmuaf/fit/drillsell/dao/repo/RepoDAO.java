package vn.hcmuaf.fit.drillsell.dao.repo;

import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RepoDAO {
    private static RepoDAO instance;

    public RepoDAO() {
    }

    public static RepoDAO getInstance() {
        if (instance == null) instance = new RepoDAO();
        return instance;
    }

    public Map<String, Object> getRepoWithProdId(int productId) {

        String sql = "                SELECT repo.repoId, repo.userId, repo.productId, repo.importQuantity, repo.importDate, repo.importPrice, repo.price, products.productName\n" +
                "                FROM repo \n" +
                "                JOIN products  ON repo.productId = products.productId \n" +
                "                WHERE repo.productId = ?\n";
        return DbConnector.me().get().withHandle(handle -> handle.createQuery(sql)
                .bind(0, productId)
                .map((row, result) -> {
                    Map<String, Object> repoMap = new HashMap<>();
                    repoMap.put("repoId", row.getInt("repoId"));
                    repoMap.put("userId", row.getInt("userId"));
                    repoMap.put("productId", row.getInt("productId"));
                    repoMap.put("importQuantity", row.getInt("importQuantity"));
                    // Chuyển đổi Timestamp thành String
                    Timestamp importDate = row.getTimestamp("importDate");
                    if (importDate != null) {
                        repoMap.put("importDate", importDate.toString());
                    } else {
                        repoMap.put("importDate", null);
                    }
                    repoMap.put("importPrice", row.getDouble("importPrice"));
                    repoMap.put("price", row.getDouble("price"));
                    repoMap.put("productName", row.getString("productName"));
                    return repoMap;
                })
                .findOne()
                .orElse(null));
    }


    public List<Map<String, Object>> getRepo() { // Thay đổi kiểu trả về thành List<Map<String, Object>>
        String sql = "   SELECT repo.repoId, repo.userId, repo.productId,repo.importQuantity, repo.importDate, repo.importPrice, repo.price, products.productName\n" +
                "                    FROM repo \n" +
                "                    JOIN products ON repo.productId = products.productId WHERE products.productStatus = 0";

        return DbConnector.me().get().withHandle(handle -> handle.createQuery(sql)
                .map((row, result) -> {
                    Map<String, Object> repoMap = new HashMap<>();
                    repoMap.put("repoId", row.getInt("repoId"));
                    repoMap.put("userId", row.getInt("userId"));
                    repoMap.put("productId", row.getInt("productId"));
                    repoMap.put("importQuantity", row.getInt("importQuantity"));

                    Timestamp importDate = row.getTimestamp("importDate");
                    if (importDate != null) {
                        repoMap.put("importDate", importDate.toString());
                    } else {
                        repoMap.put("importDate", null);
                    }

                    repoMap.put("importPrice", row.getDouble("importPrice"));
                    repoMap.put("price", row.getDouble("price"));
                    repoMap.put("productName", row.getString("productName"));
                    return repoMap;
                }).list()); // Sử dụng .list() để lấy danh sách các Map
    }


    public void addQuantity(int productId, int quantity) {
        String sql = "UPDATE repo " +
                "SET importQuantity = importQuantity + ? " +
                "WHERE productId = ?";
        DbConnector.me().get().useHandle(handle -> {
            handle.createUpdate(sql)
                    .bind(0, quantity)
                    .bind(1, productId)
                    .execute();
        });
    }

    public static void main(String[] args) {
        RepoDAO.getInstance().addQuantity(19,10);
    }
}

