package controller.shop.customer;

import model.Customer;
import service.CustomerService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CustomerChangePassServlet", value = "/shop/change-password")
public class CustomerChangePassServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getServletContext().getRequestDispatcher("/shop/change-pass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String new_pass = request.getParameter("new-pass");
        String old_pass = request.getParameter("old-pass");
        String confirm_pass = request.getParameter("confirm-pass");
        if(new_pass.equals("") || old_pass.equals("") || confirm_pass.equals("")){
            request.setAttribute("text", "Vui lòng hãy nhập vào những trường còn thiếu");
            request.getServletContext().getRequestDispatcher("/shop/change-pass.jsp").forward(request, response);
            return;
        }
        Customer customer = (Customer) request.getSession().getAttribute("auth_customer");
        System.out.println(customer);
        if(old_pass.equals(customer.getPassword())){
            if(new_pass.equals(confirm_pass)){
                if(CustomerService.changePass(new_pass, customer.getEmail())){
                    request.setAttribute("success","Đổi mật khẩu thành công");
                    request.getServletContext().getRequestDispatcher("/shop/change-pass.jsp").forward(request, response);
                }
            }else{
                request.setAttribute("text","Không hợp lệ, Xác nhận lại mật khẩu");
                request.getServletContext().getRequestDispatcher("/shop/change-pass.jsp").forward(request, response);;
            }
        }else{
            request.setAttribute("text","Không hợp lệ, Hãy nhập lại mật khẩu cũ");
            request.getServletContext().getRequestDispatcher("/shop/change-pass.jsp").forward(request, response);;
        }
    }
}
