package vn.hcmuaf.fit.drillsell.model;

public class MonthlyRevenue {
    private int year;
    private int month;
    private double totalRevenue;

    // Các getter và setter
    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        return "MonthlyRevenue{" +
                "year=" + year +
                ", month=" + month +
                ", totalRevenue=" + totalRevenue +
                '}';
    }
}
