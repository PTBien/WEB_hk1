<%@ page import="model.SubTypeProduct" %>
<%@ page import="java.util.List" %>
<%@ page import="model.StatusProduct" %>
<%@ page import="model.Supplier" %>
<%@ page import="utils.CommonString" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Thêm sản phẩm</title>
    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/admin-css.jsp"></jsp:include>
</head>

<body class="app sidebar-mini rtl">
<style>
    .Choicefile {
        display: block;
        background: #14142B;
        border: 1px solid #fff;
        color: #fff;
        width: 150px;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        padding: 5px 0px;
        border-radius: 5px;
        font-weight: 500;
        align-items: center;
        justify-content: center;
    }

    .Choicefile:hover {
        text-decoration: none;
        color: white;
    }

    #uploadfile,
    .removeimg {
        display: none;
    }

    #thumbbox {
        position: relative;
        width: 100%;
        margin-bottom: 20px;
    }

    .removeimg {
        height: 25px;
        position: absolute;
        background-repeat: no-repeat;
        top: 5px;
        left: 5px;
        background-size: 25px;
        width: 25px;
        /* border: 3px solid red; */
        border-radius: 50%;

    }

    .removeimg::before {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        content: '';
        border: 1px solid red;
        background: red;
        text-align: center;
        display: block;
        margin-top: 11px;
        transform: rotate(45deg);
    }

    .removeimg::after {
        /* color: #FFF; */
        /* background-color: #DC403B; */
        content: '';
        background: red;
        border: 1px solid red;
        text-align: center;
        display: block;
        transform: rotate(-45deg);
        margin-top: -2px;
    }
</style>

<%--    Header--%>
<%--<jsp:include page="../common/admin-header.jsp"/>--%>

<!-- Sidebar Menu -->
<jsp:include page="../common/admin-sidebar-menu.jsp"/>

<%
    List<SubTypeProduct> subTypeProductList = (List<SubTypeProduct>) session.getAttribute("ds-loai-san-pham");
    List<StatusProduct> statusProductList = (List<StatusProduct>) session.getAttribute("ds-trang-thai-san-pham");
    List<Supplier> supplierList = (List<Supplier>) session.getAttribute("ds-nha-cung-cap");

    String NameProduct = request.getParameter("TenSP") != null ? request.getParameter("TenSP") : "";
    String QuantityProduct = request.getParameter("SoLuongSP") != null ? request.getParameter("SoLuongSP") : "";
    String ListedPrice = request.getParameter("GiaNiemYetSP") != null ? request.getParameter("GiaNiemYetSP") : "";
    String CurrentPrice = request.getParameter("GiaThucTeSP") != null ? request.getParameter("GiaThucTeSP") : "";
    String DescProduct = request.getParameter("MoTaSP") != null ? request.getParameter("MoTaSP") : "";
    String SubTypeProduct = request.getParameter("LoaiSP") != null ? request.getParameter("LoaiSP") : "";
    String StatusProduct = request.getParameter("TrangThaiSP") != null ? request.getParameter("TrangThaiSP") : "";
    String Supplier = request.getParameter("NhaCungCap") != null ? request.getParameter("NhaCungCap") : "";
    String UrlImg = request.getParameter("UrlImage") != null ? request.getParameter("UrlImage") : "";

    String ErrorNameProduct = (String) request.getAttribute(CommonString.NAME_PRODUCT_ERROR);
    String ErrorQuantityProduct = (String) request.getAttribute(CommonString.QUANTITY_PRODUCT_ERROR);
    String ErrorListedPrice = (String) request.getAttribute(CommonString.LISTED_PRICE_ERROR);
    String ErrorCurrentPrice = (String) request.getAttribute(CommonString.CURRENT_PRICE_ERROR);
    String ErrorTypeProduct = (String) request.getAttribute(CommonString.TYPE_PRODUCT_ERROR);
    String ErrorStatusProduct = (String) request.getAttribute(CommonString.STATUS_PRODUCT_ERROR);
    String ErrorSupplier = (String) request.getAttribute(CommonString.SUPPLIER_ERROR);
    String ErrorUploadImg = (String) request.getAttribute(CommonString.UPLOAD_IMG_ERROR);
    String ErrorDescProduct = (String) request.getAttribute(CommonString.DESC_PRODUCT_ERROR);

%>

<main class="app-content">
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <h3 class="tile-title">Tạo mới sản phẩm</h3>
                <div class="tile-body">
                    <form id="form-add-product" class="row" method="post">
                        <div class="form-group col-md-3">
                            <label class="control-label">Tên sản phẩm</label>
                            <input class="form-control" type="text" name="TenSP" value="<%=NameProduct%>">
                            <c:set var="ErrorNameProduct" value="<%=ErrorNameProduct%>"/>
                            <c:if test="${ErrorNameProduct!=null}">
                                <div class="text-danger">${ErrorNameProduct.toString()}</div>
                            </c:if>
                        </div>
                        <div class="form-group  col-md-3">
                            <label class="control-label">Số lượng</label>
                            <input class="form-control" type="number" name="SoLuongSP" value="<%=QuantityProduct%>">
                            <c:set var="ErrorQuantityProduct" value="<%=ErrorQuantityProduct%>"/>
                            <c:if test="${ErrorQuantityProduct!=null}">
                                <div class="text-danger">${ErrorQuantityProduct.toString()}</div>
                            </c:if>
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">Giá niêm yết</label>
                            <input class="form-control" type="number" name="GiaNiemYetSP" placeholder="VND"
                                   value="<%=ListedPrice%>">
                            <c:set var="ErrorListedPrice" value="<%=ErrorListedPrice%>"/>
                            <c:if test="${ErrorListedPrice!=null}">
                                <div class="text-danger">${ErrorListedPrice.toString()}</div>
                            </c:if>
                        </div>
                        <div class="form-group col-md-3">
                            <label class="control-label">Giá bán thực tế</label>
                            <input class="form-control" type="number" name="GiaThucTeSP" placeholder="VND"
                                   value="<%=CurrentPrice%>">
                            <c:set var="ErrorCurrentPrice" value="<%=ErrorCurrentPrice%>"/>
                            <c:if test="${ErrorCurrentPrice!=null}">
                                <div class="text-danger">${ErrorCurrentPrice.toString()}</div>
                            </c:if>
                        </div>
                        <div class="form-group col-md-3">
                            <label for="typeProduct" class="control-label">Loại sản phẩm</label>
                            <select class="form-control" id="typeProduct" name="LoaiSP">
                                <option value="0" <%="0".equals(SubTypeProduct) ? "selected" : "" %>>
                                    -- Chọn loại sản phẩm -- </option>
                                <%for (SubTypeProduct stp : subTypeProductList) { %>
                                <option value="<%=stp.getId_subtype()%>"
                                        <%=(stp.getId_subtype() + "").equals(SubTypeProduct) ? "selected" : ""%>><%=stp.getName_type()%>
                                </option>
                                <% } %>
                            </select>
                            <c:set var="ErrorTypeProduct" value="<%=ErrorTypeProduct%>"/>
                            <c:if test="${ErrorTypeProduct!=null}">
                                <div class="text-danger">${ErrorTypeProduct.toString()}</div>
                            </c:if>
                        </div>
                        <div class="form-group col-md-3 ">
                            <label for="statusProduct" class="control-label">Tình trạng</label>
                            <select class="form-control" id="statusProduct" name="TrangThaiSP">
                                <option value="0" <%="0".equals(StatusProduct) ? "selected" : "" %>>
                                    -- Chọn trạng thái -- </option>
                                <% for (StatusProduct sp : statusProductList) { %>
                                <option value="<%=sp.getId_status()%>"
                                        <%=(sp.getId_status() + "").equals(StatusProduct) ? "selected" : ""%>><%=sp.getName_status()%>
                                </option>
                                <% } %>
                            </select>
                            <c:set var="ErrorStatusProduct" value="<%=ErrorStatusProduct%>"/>
                            <c:if test="${ErrorStatusProduct!=null}">
                                <div class="text-danger">${ErrorStatusProduct.toString()}</div>
                            </c:if>
                        </div>
                        <div class="form-group col-md-3 ">
                            <label for="supplier" class="control-label">Nhà cung cấp</label>
                            <select class="form-control" id="supplier" name="NhaCungCap">
                                <option value="0" <%="0".equals(Supplier) ? "selected" : "" %>>
                                    -- Chọn nhà cung cấp -- </option>
                                <%for (Supplier sl : supplierList) {%>
                                <option value="<%=sl.getId_supplier()%>"
                                        <%=(sl.getId_supplier() + "").equals(Supplier) ? "selected" : ""%>><%=sl.getName_supplier()%>
                                </option>
                                <%}%>
                            </select>
                            <c:set var="ErrorSupplier" value="<%=ErrorSupplier%>"/>
                            <c:if test="${ErrorSupplier!=null}">
                                <div class="text-danger">${ErrorSupplier.toString()}</div>
                            </c:if>
                        </div>
                        <div class="form-group col-md-12">
                            <label class="control-label">Ảnh sản phẩm</label>
                            <div id="boxchoice">
                                <a href="javascript:" class="Choicefile" onClick="ChooseImage()">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    Chọn ảnh
                                </a>
                                <a id="myfileupload">
                                    <input type="text" name="UrlImage" style="min-width:300px" value="<%=UrlImg%>"/>
                                    <c:set var="ErrorUploadImg" value="<%=ErrorUploadImg%>"/>
                                    <c:if test="${ErrorUploadImg!=null}">
                                        <div class="text-danger">${ErrorUploadImg.toString()}</div>
                                    </c:if>
                                </a>
                                <p style="clear:both"></p>
                            </div>
                        </div>
                        <div class="form-group col-md-12">
                            <label class="control-label">Mô tả sản phẩm</label>
                            <textarea class="form-control" id="descProduct" name="MoTaSP"><%=DescProduct%></textarea>
                            <c:set var="ErrorDescProduct" value="<%=ErrorDescProduct%>"/>
                            <c:if test="${ErrorDescProduct!=null}">
                                <div class="text-danger">${ErrorDescProduct.toString()}</div>
                            </c:if>
                        </div>
                        <button class="btn btn-save" type="submit">Lưu lại</button>
                        <a class="btn btn-cancel" href="<%=request.getContextPath()%>/admin/them-san-pham">Hủy bỏ</a>
                    </form>
                </div>

            </div>
        </div>
    </div>
</main>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/admin-js.jsp"></jsp:include>
<script src="../libraries/ckfinder/ckfinder.js"></script>
<script>
    <!--Hiển thị thông báo dùng sweetalert-->
    <% HttpSession sessionAlert = request.getSession();
        String ALERT = sessionAlert.getAttribute(CommonString.MESS_ALERT)!=null?(String) sessionAlert.getAttribute(CommonString.MESS_ALERT):"";
    %>
    <c:set var="Alert" value="<%=ALERT%>"/>
    <c:if test="${Alert.equals('success')}">
    $(document).ready(function () {
        swal({
            title: "Thông báo",
            text: "Chúc mừng bạn đã thêm mới sản phẩm thành công ^.^",
            type: "success"
        });
    });
    </c:if>
    <%request.getSession().removeAttribute(CommonString.MESS_ALERT);%>
</script>
<script>
    function ChooseImage() {
        var finder = new CKFinder();
        finder.selectActionFunction = DienUrlVaoInput;
        finder.popup();
    }

    <!--Đưa dường dẫn hình ảnh vào TextField input-->
    function DienUrlVaoInput(fileUrl) {
        $('input[name=UrlImage]').val(fileUrl);
    }
</script>
<!-- ================================================================================================== -->
</body>
</html>

