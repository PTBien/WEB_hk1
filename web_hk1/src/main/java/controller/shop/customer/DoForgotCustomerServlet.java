package controller.shop.customer;

import mail.Email;
import mail.SendMail;
import model.CustomerSecurity;
import service.CustomerService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "DoForgotCustomerServlet", value = "/shop/forgot-password")
public class DoForgotCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getServletContext().getRequestDispatcher("/shop/forgot-pass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        if(email.equals("")){
            request.setAttribute("error_forgot", "Email đang để trống");
            request.getServletContext().getRequestDispatcher("/shop/forgot-pass.jsp").forward(request, response);
            return;
        }
        if(!CustomerService.checkExist(email)){
            request.setAttribute("error_forgot", "Email không tồn tại trong hệ thống");
            request.getServletContext().getRequestDispatcher("/shop/forgot-pass.jsp").forward(request, response);
            return;
        }
        if(CustomerService.checkExist(email)){
            UUID uuid = UUID.randomUUID();
            String id = uuid.toString();
            UUID uuid_password = UUID.randomUUID();
            String new_pass = uuid_password.toString();
            CustomerSecurity customerSecurity = new CustomerSecurity(id, email, new_pass);
            HttpSession session = request.getSession(true);
            request.setAttribute("session_forgot", session);
            session.setAttribute("cus_forgot", customerSecurity);

            String body = "Để xác thực tài khoản đã quên mật khẩu" +
//                        "http://localhost:8080/wed_ban_noi_that_war/shop/verify-register";
                    "<a href='http://localhost:8080/Wed_ban_noi_that_war/shop/change-pass-forgot?key=" + id + "'> nhấn vào đây!</a>" + "\n" +
                    "<p style='color: red;'>Mật khẩu mới của bạn: "+new_pass+"</p>";

            Email sendEmailForForgot = new Email("thanhloc3114@gmail.com", "ovdq jmue tyno euaa",
                    "Hỗ trợ khách hàng quên mật khẩu của FUTURE", body);
            SendMail.sendMail(email, sendEmailForForgot);
            request.setAttribute("success_forgot", "Vui lòng kiểm tra lại hộp thư trong email mà bạn đăng ký");
            request.getServletContext().getRequestDispatcher("/shop/forgot-pass.jsp").forward(request, response);
        }else{
            request.setAttribute("error_forgot", "Tài khoản không tồn tại trong hệ thống");
            request.getServletContext().getRequestDispatcher("/shop/forgot-pass.jsp").forward(request, response);
        }
    }
}
