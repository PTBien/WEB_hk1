package controller.shop.product;

import database.dao.ProductDAO;
import model.Product;
import model.Review;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "details", urlPatterns = "/shop/product-details")
public class ProductDetailServlet extends HttpServlet {
    private final ProductDAO dao = new ProductDAO();
    private int productId = -1;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> hotProducts = ProductService.getSellingProducts(7);
        req.setAttribute("hot_products", hotProducts);

        List<Product> newProducts = ProductService.getNewProducts(30);
        req.setAttribute("new_products", newProducts);

        String id = req.getParameter("product_id");
        if (id != null) {
            Product product = ProductService.getProductById(productId = Integer.parseInt(id));
            if (product != null) {
                // update views
                product.setViews(product.getViews() + 1);
                ProductDAO dao = new ProductDAO();
                dao.updateProduct(product);

                List<Product> relatedProducts = ProductService.getProducts().stream()
                        .filter(p -> product.getIdProduct() != p.getIdProduct() &&
                                p.getType().equals(product.getType()) &&
                                p.getSupply().equals(product.getSupply()))
                        .limit(6).collect(Collectors.toList());
                req.setAttribute("related_products", relatedProducts);
                req.setAttribute("product", product);
                req.getRequestDispatcher("product-details.jsp").forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String content = req.getParameter("content");
        String stars = req.getParameter("stars");

        if (productId != -1) {
            Review review = new Review(productId, fullName, phone, email, content, Integer.parseInt(stars));
            dao.addReview(review);
        }
        doGet(req, resp);
    }
}
