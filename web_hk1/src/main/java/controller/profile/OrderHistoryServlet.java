package controller.profile;

import database.dao.CustomerDao;
import model.Cart;
import model.CartItem;
import model.Customer;
import model.Order;
import service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = "/shop/profile/order-history")
public class OrderHistoryServlet extends HttpServlet {
    private final CustomerDao customerDao = new CustomerDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Customer customer = (Customer) req.getSession().getAttribute("auth_customer");
        if (customer != null) {
            // for re-buy
            String orderId = req.getParameter("order_id");
            if (orderId != null) {
                List<CartItem> cartItems = CustomerService.getCartItemsByBillId(Integer.parseInt(orderId));
                Cart cart = (Cart) req.getSession().getAttribute("cart");
                if (cart == null) cart = new Cart();
                for (CartItem item : cartItems) {
                    cart.addProduct(item.getProduct(), item.getQuantity());
                }
                req.getSession().setAttribute("cart", cart);
                resp.sendRedirect(req.getContextPath() + "/shop/cart");
            } else {
                prepareOrders(req, customer.getId());
                req.getRequestDispatcher("/shop/order-history.jsp").forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("cancel");
        if (id != null) {
            customerDao.cancelOrder(Integer.parseInt(id));
        }
        resp.sendRedirect(req.getContextPath() + "/shop/profile/order-history");
    }


    private void prepareOrders(HttpServletRequest req, int customerId) {
        List<Order> orders = CustomerService.getOrderByUser(customerId);
        req.setAttribute("all_orders", orders);

        List<Order> progressOrders = new ArrayList<>(orders).stream()
                .filter(order -> order.getStatus().equalsIgnoreCase("Chờ xử lý"))
                .collect(Collectors.toList());
        req.setAttribute("progress_orders", progressOrders);

        List<Order> transportOrders = new ArrayList<>(orders).stream()
                .filter(order -> order.getStatus().equalsIgnoreCase("Đang vận chuyển"))
                .collect(Collectors.toList());
        req.setAttribute("transport_orders", transportOrders);

        List<Order> completedOrders = new ArrayList<>(orders).stream()
                .filter(order -> order.getStatus().equalsIgnoreCase("Đã giao"))
                .collect(Collectors.toList());
        req.setAttribute("completed_orders", completedOrders);

        List<Order> canceledOrders = new ArrayList<>(orders).stream()
                .filter(order -> order.getStatus().equalsIgnoreCase("Đã hủy"))
                .collect(Collectors.toList());
        req.setAttribute("canceled_orders", canceledOrders);
    }
}
