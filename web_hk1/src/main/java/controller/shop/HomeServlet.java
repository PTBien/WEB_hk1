package controller.shop;

import model.Product;
import service.ProductService;
import utils.PriceUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "HomeServlet", value = "/shop/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().removeAttribute("type");

        List<Product> hotProducts = ProductService.getSellingProducts(7);
        req.setAttribute("hot_products", hotProducts);

        List<Product> newProducts = ProductService.getNewProducts(30);
        req.setAttribute("new_products", newProducts);

        List<Product> hoaChat = ProductService.getProductsByType(1).stream()
                .sorted((p1, p2) -> p2.getSold() - p1.getSold()).collect(Collectors.toList());
        List<Product> dungCu = ProductService.getProductsByType(2).stream()
                .sorted((p1, p2) -> p2.getSold() - p1.getSold()).collect(Collectors.toList());
        List<Product> thietBi = ProductService.getProductsByType(3).stream()
                .sorted((p1, p2) -> p2.getSold() - p1.getSold()).collect(Collectors.toList());
        Map<String, List<Product>> map = new LinkedHashMap<>() {{
            put("hoa-chat", hoaChat);
            put("dung-cu", dungCu);
            put("thiet-bi", thietBi);
        }};
        req.setAttribute("product_map", map);

        List<Product> discountProducts = ProductService.getProducts().stream()
                .filter(p -> p.getOldPrice() != p.getNewPrice())
                .sorted((p1, p2) -> PriceUtil.percentDiscount(p2.getOldPrice(), p2.getNewPrice()) -
                        PriceUtil.percentDiscount(p1.getOldPrice(), p1.getNewPrice()))
                .collect(Collectors.toList());
        req.setAttribute("discount_products", discountProducts);

        List<Product> sellingProducts = ProductService.getBestSellingProducts().stream()
                .sorted((p1, p2) -> p2.getViews() - p1.getViews())
                .collect(Collectors.toList());
        req.setAttribute("selling_products", sellingProducts);

        List<Product> viewProducts = ProductService.getProducts().stream()
                .sorted((p1, p2) -> p2.getViews() - p1.getViews())
                .collect(Collectors.toList());
        req.setAttribute("view_products", viewProducts);

        Product todayDiscountProduct = null;
        try {
            todayDiscountProduct = ProductService.getTodayDiscountProducts().stream()
                    .sorted((p1, p2) -> PriceUtil.percentDiscount(p2.getOldPrice(), p2.getNewPrice()) -
                            PriceUtil.percentDiscount(p1.getOldPrice(), p1.getNewPrice()))
                    .collect(Collectors.toList()).get(0);
        } catch (IndexOutOfBoundsException | NullPointerException ignored) {
        }
        req.setAttribute("today_discount_product", todayDiscountProduct);

        getServletContext().getRequestDispatcher("/shop/home.jsp").forward(req, resp);
    }
}
