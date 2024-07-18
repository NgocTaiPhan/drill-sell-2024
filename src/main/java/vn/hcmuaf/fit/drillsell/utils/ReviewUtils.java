package vn.hcmuaf.fit.drillsell.utils;

import vn.hcmuaf.fit.drillsell.dao.ReviewDAO;
import vn.hcmuaf.fit.drillsell.model.Review;

import java.util.List;

public class ReviewUtils {
    public static void addReview(Review review) {
        ReviewDAO.getInstance().insertReview(review);
    }

    public static List<Review> getAllReviewByPID(int productId) {
        return ReviewDAO.getInstance().getAllReviewByPID(productId);
    }
}
