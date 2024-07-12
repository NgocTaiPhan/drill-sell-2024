package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;
import vn.hcmuaf.fit.drillsell.model.Review;

import java.util.List;

public class ReviewDAO {
    private static ReviewDAO instance;

    public ReviewDAO() {
    }

    public static ReviewDAO getInstance() {
        if (instance == null) {
            instance = new ReviewDAO();
        }
        return instance;
    }

    public void insertReview(Review r) {
        DbConnector.me().get().useHandle(handle -> {
            String sql = "INSERT INTO reviews (userId, productId, rating, mess) VALUES (?, ?, ?, ?)";
            handle.createUpdate(sql)
                    .bind(0, r.getUserId())
                    .bind(1, r.getProductId())
                    .bind(2, r.getRating())
                    .bind(3, r.getMess())
                    .execute();

            System.out.println("Đã thêm review cho sản phẩm: " + r.getProductId());
        });
    }

    public List<Review> getAllReviewByPID(int productId) {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT  userId, productId, rating, mess, dateReview FROM reviews WHERE productId = :productId")
                        .bind("productId", productId)
                        .mapToBean(Review.class)
                        .list());
    }

}
