package controller.admin.product;

import model.Admin;
import model.Product;
import service.ProductService;
import utils.CommonString;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AjaxUpdateProductServlet", value = "/AjaxUpdateProductServlet")
public class AjaxUpdateProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Admin admin = (Admin) request.getSession().getAttribute(CommonString.ADMIN_SESSION);

        String idProd = request.getParameter("IdSP");
        String nameProd = request.getParameter("TenSP");
        String quantityProd = request.getParameter("SoLuongSP");
        String listedPriceProd = request.getParameter("GiaNiemYetSP");
        String currentPriceProd = request.getParameter("GiaHienTaiSP");
        String idStatusProd = request.getParameter("IdTrangThaiSP");
        String idSubtypeProd = request.getParameter("IdLoaiSP");

        try {
            int id = Integer.parseInt(idProd);
            int quantity = Integer.parseInt(quantityProd);
            int listedPrice = Integer.parseInt(listedPriceProd);
            int currentPrice = Integer.parseInt(currentPriceProd);
            int idStatus = Integer.parseInt(idStatusProd);
            int idSubtype = Integer.parseInt(idSubtypeProd);
            Product p = new Product(id, nameProd, quantity, listedPrice, currentPrice, idSubtype, idStatus);
            boolean checkUpdate = ProductService.updateProductById(p, admin);
            if (checkUpdate) response.getWriter().write("success");
            else response.getWriter().write("fail");
        } catch (Exception e) {
            response.getWriter().write("error");
        }


    }
}
