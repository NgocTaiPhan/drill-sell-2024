package vn.hcmuaf.fit.drillsell.model;

import org.jetbrains.annotations.Nullable;

import java.sql.Timestamp;

public class LogCart {
    private int id;
    private int userId;
    private int cartId;
    private String stauss;
    @Nullable
    private Timestamp timeUpdate;

    public LogCart() {
    }

    public LogCart(int id, int userId, int cartId, String stauss, @Nullable Timestamp timeUpdate) {
        this.id = id;
        this.userId = userId;
        this.cartId = cartId;
        this.stauss = stauss;
        this.timeUpdate = timeUpdate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public String getStauss() {
        return stauss;
    }

    public void setStauss(String stauss) {
        this.stauss = stauss;
    }

    public Timestamp getTimeUpdate() {
        return timeUpdate;
    }

    public void setTimeUpdate(Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }

    @Override
    public String toString() {
        return "LogCart{" +
                "id=" + id +
                ", userId=" + userId +
                ", cartId=" + cartId +
                ", stauss='" + stauss + '\'' +
                ", timeUpdate=" + timeUpdate +
                '}';
    }
}
