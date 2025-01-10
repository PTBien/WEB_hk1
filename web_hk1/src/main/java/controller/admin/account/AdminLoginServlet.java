package controller.admin.account;

import model.Admin;
import service.AdminService_MT;
import utils.CommonString;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminLogin", value = "/admin/dang-nhap")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/admin-jsp/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String passAD = request.getParameter("password");
        Admin admin = AdminService_MT.checkLogin(username, passAD); // call service
        if (admin == null) {
            request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/admin-jsp/login.jsp").forward(request, response); // return view
        } else {

            HttpSession session = request.getSession(true);
            session.setAttribute(CommonString.ADMIN_SESSION, admin);
            int status_acc = admin.getId_status_acc();
            if (status_acc == 1) {

                response.sendRedirect(request.getContextPath() + "/admin/trang-chu");

            } else {

                request.setAttribute("Alert","login_fail");
                request.getRequestDispatcher("/admin-jsp/login.jsp").forward(request, response);

            }

        }
    }
}
