package controller.profile;

import model.Customer;
import service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "ProfileCustomerServlet", value = "/shop/profile_customer")
public class ProfileCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.getAttribute("auth_session_customer");
        Customer customer = (Customer) session.getAttribute("auth_customer");
        if(customer != null){
            HttpSession session1 = request.getSession(true);
            request.setAttribute("session_city", session1);
            session1.setAttribute("citiess", CustomerService.getCities());
            request.getRequestDispatcher("/shop/profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.getAttribute("auth_session_customer");
        Customer customer = (Customer) session.getAttribute("auth_customer");
        String fullname = request.getParameter("name");
        String sex = request.getParameter("sex");
        String phone = request.getParameter("phone");
        String email_customer = request.getParameter("email_customer");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        int parse_city = Integer.parseInt(city);
        boolean result = CustomerService.profile(customer.getEmail(),fullname,parse_city,sex,email_customer,phone,address);
        Pattern pattern = Pattern.compile("(84|0[3|5|7|8|9])+([0-9]{8})\\b");
        Matcher matcher = pattern.matcher(phone);
        if(!matcher.matches()){
            request.setAttribute("error_profile", "Số điện thoại không hợp lệ");
            request.getServletContext().getRequestDispatcher("/shop/profile.jsp").forward(request,response);
            return;
        }
        if(result){
            response.sendRedirect(request.getContextPath() + "/shop/DoLogoutCustomer");
            HttpSession session1 = (HttpSession) request.getSession();
            session1.getAttribute("session_city");
            session1.invalidate();
        }else{
            request.setAttribute("error_profile", "Cập nhập không thành công");
            request.getRequestDispatcher("/shop/profile.jsp").forward(request,response);
        }
        
    }
}
