package controller.shop.checkout;

import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateCheckoutServer", urlPatterns = "/shop/update-checkout")
public class UpdateCheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String city = req.getParameter("city");
        if (city != null) {
            Customer customer = (Customer) req.getSession().getAttribute("auth_customer");
            if (customer != null) {
                customer.setId_city(Integer.parseInt(city));
                resp.sendRedirect(req.getContextPath() + "/shop/checkout");
            }
        }
    }
}
