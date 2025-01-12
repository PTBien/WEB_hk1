package controller.admin.account;

import model.Admin;
import service.AdminService_MT;
import utils.CommonString;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminsManagerServlet", value = "/admin/quan-ly-admin")
public class AdminsManagerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Admin admin = (Admin) request.getSession().getAttribute(CommonString.ADMIN_SESSION);
        if (admin.getId_role_admin() == 2) {
            List<Admin> listAdmin = AdminService_MT.getAllAdmin();
            List<Object> allRoleAdminAndStatusAcc = AdminService_MT.getAllRoleAdminAndStatusAcc();
            request.setAttribute("adminList", listAdmin);
            request.setAttribute("allRoleAdmin", allRoleAdminAndStatusAcc.get(0));
            request.setAttribute("allStatusAcc", allRoleAdminAndStatusAcc.get(1));
            request.getRequestDispatcher("/admin-jsp/admins-manager.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/trang-chu");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String UserName = request.getParameter("UserName");
        String PassAd = request.getParameter("PassAd");
        String IdRole = request.getParameter("IdRole");
        String IdStatus = request.getParameter("IdStatus");

        try {
            int id_role_admin = Integer.parseInt(IdRole);
            int id_status_acc = Integer.parseInt(IdStatus);
            Admin admin = new Admin(UserName, PassAd, id_role_admin, id_status_acc, "");
            boolean checkUpdateAcc = AdminService_MT.updateAccount(admin);
            if (checkUpdateAcc) {
                response.getWriter().write("success");
            } else response.getWriter().write("fail");
        } catch (Exception e) {
            response.getWriter().write("error");
        }

    }
}
