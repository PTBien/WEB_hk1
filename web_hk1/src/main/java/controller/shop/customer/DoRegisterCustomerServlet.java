package controller.shop.customer;

import mail.Email;
import mail.SendMail;
import model.CustomerSecurity;
import service.CustomerService;
import utils.EmailValidator;
import utils.PasswordUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "DoRegisterCustomerServlet", value = "/shop/register")
public class DoRegisterCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getServletContext().getRequestDispatcher("/shop/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm_pass = request.getParameter("confirm-pass");
        if (!EmailValidator.isValidEmail(email)) {
            request.setAttribute("text_register", "Email không hợp lệ, vui lòng nhập lại.");
            request.getServletContext().getRequestDispatcher("/shop/register.jsp").forward(request, response);
            return;
        }

        if(email.equals("") || password.equals("") || confirm_pass.equals("")){
            request.setAttribute("text_register", "Vui lòng hãy nhập vào những trường còn thiếu");
            request.getServletContext().getRequestDispatcher("/shop/register.jsp").forward(request, response);
            return;
        }
        if (CustomerService.checkExist(email)) {
            request.setAttribute("text_register", "Email đã tồn tại, vui lòng chọn Email khác");
            request.getServletContext().getRequestDispatcher("/shop/register.jsp").forward(request, response);
        } else {
            if (password.equals(confirm_pass)) {
                UUID uuid = UUID.randomUUID();
                String id = uuid.toString();

                 String hashedPassword = PasswordUtil.hashPassword(password);

                CustomerSecurity customer_register = new CustomerSecurity(id, email, hashedPassword);
                HttpSession session = request.getSession(true);
                request.setAttribute("session_cus", session);
                session.setAttribute("cus", customer_register);

                String body = "Để tạo tài khoản và sử dụng các dịch vụ của chúng tôi hãy " +
//                        "http://localhost:8080/shop/verify-register";
                        "<a href='http://localhost:8080/shop/verify-register?key=" + id + "'>nhấn vào đây!</a>";
                Email sendEmailForVerify = new Email("20130203@st.hcmuaf.edu.vn", "zyqc shbm dolw oyyk",
                        "Chào mừng bạn trở thành một phần của nội thất Future", body);
                SendMail.sendMail(email, sendEmailForVerify);
                request.setAttribute("success_register", "Vui lòng kiểm tra lại hộp thư trong email mà bạn đăng ký");
                request.getServletContext().getRequestDispatcher("/shop/register.jsp").forward(request, response);
            } else {
                request.setAttribute("text_register", "Xác thực mật khẩu không hợp lệ, vui lòng thử lại");
                request.getServletContext().getRequestDispatcher("/shop/register.jsp").forward(request, response);
            }
        }
    }
}
