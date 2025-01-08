package model;

import java.io.Serializable;
import java.text.DecimalFormat;

public class ProductReview implements Serializable {
    private int productId;
    private int fiveStars;
    private int fourStars;
    private int threeStars;
    private int twoStars;
    private int oneStars;
    private int totals;

    public ProductReview() {}

    public ProductReview(int productId, int fiveStars, int fourStars, int threeStars, int twoStars, int oneStars, int totals) {
        this.productId = productId;
        this.fiveStars = fiveStars;
        this.fourStars = fourStars;
        this.threeStars = threeStars;
        this.twoStars = twoStars;
        this.oneStars = oneStars;
        this.totals = totals;
    }

    @Override
    public String toString() {
        return "ProductReview{" +
                "productId=" + productId +
                ", fiveStars=" + fiveStars +
                ", fourStars=" + fourStars +
                ", threeStars=" + threeStars +
                ", twoStars=" + twoStars +
                ", oneStars=" + oneStars +
                ", totals=" + totals +
                '}';
    }

    public int getPercent5() {
        if (totals == 0) return 0;
        return 100 - getPercent4() - getPercent3() - getPercent2() - getPercent1();
    }

    public int getPercent4() {
        if (totals == 0) return 0;
        return fourStars * 100 / totals;
    }

    public int getPercent3() {
        if (totals == 0) return 0;
        return threeStars * 100 / totals;
    }

    public int getPercent2() {
        if (totals == 0) return 0;
        return twoStars * 100 / totals;
    }

    public int getPercent1() {
        if (totals == 0) return 0;
        return oneStars * 100 / totals;
    }

    public float getAverage() {
        if (totals == 0) return 0;
        float average = (fiveStars * 5f + fourStars * 4f + threeStars * 3f + twoStars * 2f + oneStars) / totals;
        DecimalFormat df = new DecimalFormat();
        df.setMaximumFractionDigits(2);
        return Float.parseFloat(df.format(average));
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getFiveStars() {
        return fiveStars;
    }

    public void setFiveStars(int fiveStars) {
        this.fiveStars = fiveStars;
    }

    public int getFourStars() {
        return fourStars;
    }

    public void setFourStars(int fourStars) {
        this.fourStars = fourStars;
    }

    public int getThreeStars() {
        return threeStars;
    }

    public void setThreeStars(int threeStars) {
        this.threeStars = threeStars;
    }

    public int getTwoStars() {
        return twoStars;
    }

    public void setTwoStars(int twoStars) {
        this.twoStars = twoStars;
    }

    public int getOneStars() {
        return oneStars;
    }

    public void setOneStars(int oneStars) {
        this.oneStars = oneStars;
    }

    public int getTotals() {
        return totals;
    }

    public void setTotals(int totals) {
        this.totals = totals;
    }
}
