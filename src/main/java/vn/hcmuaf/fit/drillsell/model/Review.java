package vn.hcmuaf.fit.drillsell.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Review {
    private int reviewId;

    private int userId;

    private int productId;

    private int rating;

    private java.sql.Timestamp dateReview;

    private String mess;

    public Review() {
    }

    public Review(int userId, int productId, int rating, String mess) {
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.mess = mess;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public java.sql.Timestamp getDateReview() {
        return dateReview;
    }

    public void setDateReview(Timestamp dateReview) {
        this.dateReview = dateReview;
    }

    public String getMess() {
        return mess;
    }

    public void setMess(String mess) {
        this.mess = mess;
    }

    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", userId=" + userId +
                ", productId=" + productId +
                ", rating=" + rating +
                ", dateReview=" + dateReview +
                ", mess='" + mess + '\'' +
                '}';
    }
}
