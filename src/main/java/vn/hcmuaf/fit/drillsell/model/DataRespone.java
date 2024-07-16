package vn.hcmuaf.fit.drillsell.model;

import java.sql.Date;

public class DataRespone {
    private double deliveryFee;
    private Date deliveryDate;

    public DataRespone() {}

    public DataRespone(double deliveryFee, Date deliveryDate) {
        this.deliveryFee = deliveryFee;
        this.deliveryDate = deliveryDate;
    }

    public double getDeliveryFee() {
        return deliveryFee;
    }

    public void setDeliveryFee(double deliveryFee) {
        this.deliveryFee = deliveryFee;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    @Override
    public String toString() {
        return "DataRespone{" +
                "deliveryFee='" + deliveryFee + '\'' +
                ", deliveryDate='" + deliveryDate + '\'' +
                '}';
    }
}

