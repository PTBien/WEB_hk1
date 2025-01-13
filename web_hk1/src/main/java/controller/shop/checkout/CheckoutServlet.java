package controller.shop.checkout;

import database.dao.CustomerDao;
import model.Cart;
import model.CartItem;
import model.Customer;
import service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "checkout-servlet", urlPatterns = "/shop/checkout")
public class CheckoutServlet extends HttpServlet {
    private final CustomerDao customerDao = new CustomerDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Customer customer = (Customer) req.getSession().getAttribute("auth_customer");
        if (customer != null) {
            Cart cart = (Cart) req.getSession().getAttribute("cart");
            if (cart != null) {
                double billPrice = cart.getTotalPrice();
                req.setAttribute("bill_price", billPrice);
                double transportFee = CustomerService.getTransportFee(customer.getId_city());
                req.setAttribute("transport_fee", transportFee);
                req.setAttribute("cities", CustomerService.getCities());
                req.getRequestDispatcher("/shop/checkout.jsp").forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        Customer cus = (Customer) req.getSession().getAttribute("auth_customer");
        Cart cart = (Cart) req.getSession().getAttribute("cart");

        int billId = customerDao.addBill(cus.getId(), cus.getId_city(), name, phone, email, address, cart.getTotalPrice(),
                cart.getTotalPrice() + CustomerService.getTransportFee(cus.getId_city()));

        for (Map.Entry<Integer, CartItem> item : cart.getMap().entrySet()) {
            customerDao.addBillDetail(billId, item.getKey(), item.getValue().getQuantity(),
                    item.getValue().getProduct().getOldPrice(), item.getValue().getProduct().getNewPrice());
        }

        req.getSession().removeAttribute("cart");
        String nav = req.getParameter("nav");
        if (nav != null)
            resp.sendRedirect(req.getContextPath() + "/shop/profile/order-history");
        else
            resp.sendRedirect(req.getContextPath() + "/shop/home");
    }
}
