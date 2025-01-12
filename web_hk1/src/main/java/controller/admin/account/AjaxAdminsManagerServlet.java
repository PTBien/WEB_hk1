package controller.admin.account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AjaxAdminsManagerServlet", value = "/AjaxAdminsManagerServlet")
public class AjaxAdminsManagerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idRole = request.getParameter("IdRoleAdmin");
        try {
            Integer idRoleAdmin = Integer.parseInt(idRole);
            if (idRoleAdmin == 2) {
                response.getWriter().write(request.getContextPath() + "/admin/quan-ly-admin");
            } else {
                response.getWriter().write("fail");
            }
        } catch (Exception e) {
            response.getWriter().write("fail");
        }
    }
}
