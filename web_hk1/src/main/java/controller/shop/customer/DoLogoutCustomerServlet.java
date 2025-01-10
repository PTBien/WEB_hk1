package controller.shop.customer;

import model.Cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DoLogoutCustomerServlet", value = "/shop/DoLogoutCustomer")
public class DoLogoutCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = (HttpSession) request.getSession();
        session.getAttribute("auth_session_customer");
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) cart.invalidate();
        session.invalidate();
        response.sendRedirect(request.getContextPath()+ "/shop/home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
