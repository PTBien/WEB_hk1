package controller.shop.product;

import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "products", urlPatterns = "/shop/products")
public class ProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = ProductService.getProducts();

        if (req.getParameter("search") == null && req.getParameter("type") == null && req.getParameter("subtype") == null) {
            req.getSession().removeAttribute("type");
            req.getSession().setAttribute("all_products", ProductService.getTypes());
        } else
            req.getSession().removeAttribute("all_products");

        // searching
        String name = req.getParameter("search");
        if (name != null) {
            req.getSession().removeAttribute("type");
            products = ProductService.searchProductsByName(name);
        }

        String type = req.getParameter("type");
        if (type == null) type = String.valueOf(req.getSession().getAttribute("type"));

        if (!type.equals("null")) {
            req.getSession(true).setAttribute("type", type);
            products = ProductService.getProductsByType(Integer.parseInt(type));
            req.setAttribute("subtypes", ProductService.getSubtypesByType(Integer.parseInt(type)));
        }

        // categorizing
        String subtype = req.getParameter("subtype");
        if (subtype != null) {
            type = String.valueOf(ProductService.getTypeBySubtypeId(Integer.parseInt(subtype)));
            req.getSession(true).setAttribute("type", type);
            products = ProductService.getProductsBySubtype(Integer.parseInt(subtype));
            req.setAttribute("subtypes", ProductService.getSubtypesByType(Integer.parseInt(type)));
        }
        // filtering
        String minPrice = req.getParameter("minPrice"), maxPrice = req.getParameter("maxPrice");
        double min = minPrice != null ? Double.parseDouble(minPrice) : Double.MIN_VALUE;
        double max = maxPrice != null ? Double.parseDouble(maxPrice) : Double.MAX_VALUE;

        products = products.stream()
                .filter(product -> product.getNewPrice() >= min && product.getNewPrice() <= max)
                .collect(Collectors.toList());
        // sorting
        String param = req.getParameter("sortBy");
        if (param == null || param.equals("name"))
            products.sort(Comparator.comparing(Product::getName));
        else if (param.equals("price_up"))
            products.sort(Comparator.comparing(Product::getNewPrice));
        else if (param.equals("price_down"))
            products.sort((o1, o2) -> (int) (o2.getNewPrice() - o1.getNewPrice()));

        req.setAttribute("products", products);

        List<Product> hotProducts = ProductService.getSellingProducts(7);
        req.setAttribute("hot_products", hotProducts);

        List<Product> newProducts = ProductService.getNewProducts(30);
        req.setAttribute("new_products", newProducts);

        req.setAttribute("suppliers", ProductService.getSuppliers());

        req.getRequestDispatcher("/shop/products.jsp").forward(req, resp);
    }

    private void setPriceRange(HttpServletRequest req, List<Product> products) {
        int r1 = 0, r2 = 0, r3 = 0;
        for (Product product : products) {
            if (product.getNewPrice() >= 200000 && product.getNewPrice() <= 500000) r1++;
            if (product.getNewPrice() >= 500000 && product.getNewPrice() <= 1000000) r2++;
            if (product.getNewPrice() >= 1000000 && product.getNewPrice() <= 2500000) r3++;
        }
        req.setAttribute("r1", r1);
        req.setAttribute("r2", r2);
        req.setAttribute("r3", r3);
    }

    private void setBreadCrumbs(String type, String subtype, HttpServletRequest req) {
        if (subtype != null) {
            req.setAttribute("bc_t", ProductService.getTypeName(Integer.parseInt(type)));
            req.setAttribute("bc_st", ProductService.getSubtypesByType(Integer.parseInt(type)).get(Integer.parseInt(subtype)));
        } else if (!type.equals("null")) {
            req.setAttribute("bc_t", ProductService.getTypeName(Integer.parseInt(type)));
        }
    }
}
