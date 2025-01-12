package controller.admin.account;

import model.Admin;
import service.AdminService_MT;
import utils.CommonString;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminChangePass", value = "/admin/doi-mat-khau")
public class AdminChangePassServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/admin-jsp/settings.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String old_pass = request.getParameter("old-pass");
        String new_pass = request.getParameter("new-pass");
        Admin admin = (Admin) request.getSession().getAttribute(CommonString.ADMIN_SESSION);
        if (old_pass.equals(admin.getPassAD())) {

            boolean checkUpdate = AdminService_MT.updatePassword(admin.getUsername(), new_pass); // call service
            if (checkUpdate == true) {

                response.sendRedirect(request.getContextPath()+"/admin/dang-nhap");

            } else {

                request.setAttribute("notification", "Cập nhật không thành công ^.^");
                request.getRequestDispatcher("/admin-jsp/settings.jsp").forward(request, response);

            }

        } else {

            request.setAttribute("error", "Hãy nhập lại mật khẩu cũ");
            request.getRequestDispatcher("/admin-jsp/settings.jsp").forward(request, response);

        }
    }
}
