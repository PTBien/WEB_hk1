package controller.admin.product;

import model.Admin;
import model.Product;
import model.StatusProduct;
import model.SubTypeProduct;
import service.ProductService;
import utils.CommonString;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.function.Supplier;
import java.util.regex.Pattern;

/*
@MultipartConfig
        (maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
*/

@WebServlet(name = "AdminAddProduct", value = "/admin/them-san-pham")

public class AdminAddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Object> results = ProductService.getSubTypeAndStatusAndSupplierForProduct();
        List<SubTypeProduct> subtypeProducts = (List<SubTypeProduct>) results.get(0);
        List<StatusProduct> statusProducts = (List<StatusProduct>) results.get(1);
        List<Supplier> suppliers = (List<Supplier>) results.get(2);

        request.getSession().setAttribute("ds-loai-san-pham", subtypeProducts);
        request.getSession().setAttribute("ds-trang-thai-san-pham", statusProducts);
        request.getSession().setAttribute("ds-nha-cung-cap", suppliers);

        request.getRequestDispatcher("/admin-jsp/form-add-product.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Product p = new Product();

        String nameProduct = request.getParameter("TenSP");
        String quantityProduct = request.getParameter("SoLuongSP");
        String listedPrice = request.getParameter("GiaNiemYetSP");
        String currentPrice = request.getParameter("GiaThucTeSP");
        String id_subTypeProduct = request.getParameter("LoaiSP");
        String id_statusProduct = request.getParameter("TrangThaiSP");
        String id_supplier = request.getParameter("NhaCungCap");
        String url_img = request.getParameter("UrlImage");
        String description = request.getParameter("MoTaSP");

        boolean validateName = true;
        boolean validateQuantity = true;
        boolean validateListed = true;
        boolean validateCurrent = true;
        boolean validateType = true;
        boolean validateStatus = true;
        boolean validateSupplier = true;
        boolean validateUrlImg = true;
        boolean validateDesc = true;


        if (nameProduct.isEmpty() || nameProduct.length() <= 5) {

            request.setAttribute(CommonString.NAME_PRODUCT_ERROR
                    , "Tên của sản phẩm không được để trống và phải lớn hơn 5 kí tự !!!");
            validateName = false;
        } else p.setName(nameProduct);

        if (description.isEmpty() || description.length() <= 20) {

            request.setAttribute(CommonString.DESC_PRODUCT_ERROR
                    , "Mô tả của sản phẩm không được để trống và phải lớn hơn 20 kí tự !!!");
            validateDesc = false;
        } else p.setDesc(description);

        try {
            int quantity = Integer.parseInt(quantityProduct);
            if (quantity < 0 || quantity > 10000) {
                request.setAttribute(CommonString.QUANTITY_PRODUCT_ERROR,
                        "Số lượng sản phẩm không được âm và không được vượt quá 10 ngàn sản phẩm");
                validateQuantity = false;
            } else {
                p.setQuantity(quantity);
            }
        } catch (Exception e) {

            request.setAttribute(CommonString.QUANTITY_PRODUCT_ERROR,
                    "Số lưọng sản phẩm không được là chữ và không được để trống!!!");
            validateQuantity = false;
        }

        try {
            int lPrice = Integer.parseInt(listedPrice);
            if (lPrice < 0 || (lPrice > Math.pow(10, 6) * 500)) {

                request.setAttribute(CommonString.LISTED_PRICE_ERROR,
                        "Giá của sản phẩm không được âm và không được vượt quá 500 triệu đồng");
                validateListed = false;
            } else {

                p.setListed_price(lPrice);
            }

        } catch (Exception e) {

            request.setAttribute(CommonString.LISTED_PRICE_ERROR,
                    "Giá của sản phẩm không được là chữ và không được để trống!!!");
            validateListed = false;
        }

        try {
            int cPrice = Integer.parseInt(currentPrice);
            if (cPrice < 0 || (cPrice > Math.pow(10, 6) * 500)) {

                request.setAttribute(CommonString.CURRENT_PRICE_ERROR,
                        "Giá của sản phẩm không được âm và không được vượt quá 500 triệu đồng");
                validateCurrent = false;
            } else {

                p.setCurrent_price(cPrice);
            }
        } catch (Exception e) {

            request.setAttribute(CommonString.CURRENT_PRICE_ERROR,
                    "Giá của sản phẩm không được là chữ và không được để trống!!!");
            validateCurrent = false;
        }

        try {

            int id_type = Integer.parseInt(id_subTypeProduct);
            if (id_type == 0) {

                request.setAttribute(CommonString.TYPE_PRODUCT_ERROR,
                        "Hãy chọn loại sản phẩm !!!");
                validateType = false;

            } else {

                p.setType_product(id_type);
            }

        } catch (Exception e) {

            request.setAttribute(CommonString.TYPE_PRODUCT_ERROR,
                    "Hãy chọn lại loại sản phẩm !!!");
            validateType = false;
        }

        try {
            int id_status = Integer.parseInt(id_statusProduct);
            if (id_status == 0) {

                request.setAttribute(CommonString.STATUS_PRODUCT_ERROR,
                        "Hãy chọn trạng thái sản phẩm !!!");
                validateStatus = false;

            } else {

                p.setStatus_product(id_status);
            }
        } catch (Exception e) {

            request.setAttribute(CommonString.STATUS_PRODUCT_ERROR,
                    "Hãy chọn lại trạng thái sản phẩm !!!");
            validateStatus = false;
        }

        try {
            int id_suppl = Integer.parseInt(id_supplier);
            if (id_suppl == 0) {

                request.setAttribute(CommonString.SUPPLIER_ERROR,
                        "Hãy chọn nhà cung cấp !!!");
                validateSupplier = false;
            } else {

                p.setSupplier(id_suppl);
            }
        } catch (Exception e) {

            request.setAttribute(CommonString.SUPPLIER_ERROR,
                    "Hãy chọn lại nhà cung cấp !!!");
            validateSupplier = false;
        }

        if (url_img.isEmpty()) {
            request.setAttribute(CommonString.UPLOAD_IMG_ERROR, "Hãy chọn hình ảnh cho sản phẩm !!!");
            validateUrlImg = false;
        } else {
            var pattern = Pattern.compile("([^\\s]+(\\.(?i)(jpe?g|png|gif|bmp))$)");
            var matcher = pattern.matcher(url_img);
            if (matcher.matches() == false) {
                request.setAttribute(CommonString.UPLOAD_IMG_ERROR, "Hình ảnh của sản phẩm không đúng định dạng, hãy chọn lại !!!");
                validateUrlImg = false;
            } else {
                p.setImgPath(url_img);
            }
        }

        boolean validateAll = validateName && validateQuantity && validateListed && validateCurrent
                && validateType && validateStatus && validateSupplier && validateUrlImg && validateDesc;

        if (validateAll) {
            try {
                Admin admin = (Admin) request.getSession().getAttribute(CommonString.ADMIN_SESSION);
                boolean checkAddProduct = ProductService.addNewProduct(p, admin);
                if (checkAddProduct) {

                    request.getSession().setAttribute(CommonString.MESS_ALERT, "success");
                    response.sendRedirect(request.getContextPath() + "/admin/them-san-pham");

                    /*
                     * RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/admin/them-san-pham");
                     * dispatcher.forward(request,response);
                     * => chuyển tiếp đến một servlet khác
                     */

                } else {

                    response.sendRedirect(request.getContextPath() + "/admin/them-san-pham");
                }
            } catch (Exception e) {

                response.getWriter().println("Đã xảy ra lỗi");
            }
        } else {

            request.getRequestDispatcher("/admin-jsp/form-add-product.jsp").forward(request, response);

        }


    }



}
