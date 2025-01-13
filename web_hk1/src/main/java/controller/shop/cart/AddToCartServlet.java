package controller.shop.cart;

import database.dao.ProductDAO;
import model.Cart;
import model.Product;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "add_to_cart", urlPatterns = "/shop/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private final ProductDAO dao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productId = req.getParameter("product_id");
        if (productId != null) {
            Product product = ProductService.getProductById(Integer.parseInt(productId));
            int remainQuantity = ProductService.getRemainQuantity(product.getIdProduct());

            Cart cart = (Cart) req.getSession().getAttribute("cart");
            if (cart == null) cart = new Cart();

            String action = req.getParameter("action");
            if (action != null) {
                switch (action) {
                    case "add":
                        String quantity = req.getParameter("quantity");
                        int qnt = quantity == null ? 1 : Integer.parseInt(quantity);

                        if (remainQuantity < qnt) {
                            break;
                        }

                        cart.addProduct(product, qnt);
                        dao.updateQuantity(product.getIdProduct(), remainQuantity - qnt);
                        break;
                    case "remove":
                        cart.removeProduct(product);
                        dao.updateQuantity(product.getIdProduct(), remainQuantity + 1);
                        break;
                    case "delete":
                        int deleteQuantities = cart.getMap().get(product.getIdProduct()).getQuantity();
                        cart.deleteProduct(product);
                        dao.updateQuantity(product.getIdProduct(), remainQuantity + deleteQuantities);
                        break;
                }
            } else if (remainQuantity >= 1) {
                cart.addProduct(product, 1);
                dao.updateQuantity(product.getIdProduct(), remainQuantity - 1);
            }

            req.getSession().setAttribute("cart", cart);
            resp.sendRedirect(req.getHeader("referer"));
        }
    }
}
