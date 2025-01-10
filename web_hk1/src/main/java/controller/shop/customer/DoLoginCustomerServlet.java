package controller.shop.customer;

import model.Customer;
import service.CustomerService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginCustomer", value = "/shop/login")
public class DoLoginCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/shop/login.jsp");
        dispatcher.forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if(email.equals("") || password.equals("")){
            request.setAttribute("error","Email hoặc mật khẩu đang bị trống");
            request.getServletContext().getRequestDispatcher("/shop/login.jsp").forward(request,response);
            return;
        }
        Customer customer = CustomerService.checkLogin(email, password);
        if(customer != null){
            if(customer.getId_status_acc() == 1) {
                HttpSession session = request.getSession(true);
                request.setAttribute("auth_session_customer", session);
                session.setAttribute("auth_customer", customer);
                response.sendRedirect(request.getContextPath() + "/shop/home");
            }else if(customer.getId_status_acc() == 2){
                request.setAttribute("error", "Tài khoản tạm khóa");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }else{
                request.setAttribute("error", "Tài khoản đã bị khóa vĩnh viễn");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }else{
            request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
