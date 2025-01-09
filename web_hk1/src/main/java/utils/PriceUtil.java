package utils;

import model.Product;

import java.text.NumberFormat;
import java.util.List;

public final class PriceUtil {

    private PriceUtil() {
        throw new AssertionError();
    }

    public static String format(double price) {
        NumberFormat nf = NumberFormat.getNumberInstance();
        return nf.format(price);
    }

    public static int percentDiscount(double oldPrice, double newPrice) {
        return (int) (100 * (1 - newPrice / oldPrice));
    }

    public static boolean inList(Product product, List<Product> products) {
        return products.stream().anyMatch(p -> p.getIdProduct() == product.getIdProduct());
    }
}
