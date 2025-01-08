<%@ page import="model.Admin" %>
<%@ page import="utils.CommonString" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Đổi mật khẩu</title>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/admin-css.jsp"/>
</head>

<body class="app sidebar-mini rtl">

<%--<jsp:include page="../common/admin-header.jsp"/>--%>

<jsp:include page="../common/admin-sidebar-menu.jsp"/>
<% String error = (String) request.getAttribute("error");
    String noti = (String) request.getAttribute("notification");
    Admin admin = (Admin) session.getAttribute(CommonString.ADMIN_SESSION);%>
<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="#"><b>Đổi mật khẩu</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>
    <div class="row system-settings">
        <div class="col-lg-4">
            <div class="left text-left">
                <span class="d-inline-block mb-3"><b>Hình ảnh hồ sơ</b></span>
                <div class="img-container">
                    <img src="${context}/admin-assets/images/admin.jpg" alt="">
                    <button><i class="bx bx-pencil"></i> Sửa</button>
                </div>
                <p class="text-center"><b>Admin</b></p>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="right pb-4">
                <form method="post" name="form-change-pass"
                      onsubmit="return validateFormChangePass()">
                    <label class="d-block" for="name">Tên <span>*</span></label>
                    <input type="text" id="name" value="<%=admin.getFullname()%>">
                    <h4 class=" position-relative mt-3 mb-4">Đổi mật khẩu</h4>
                    <label class="d-block mt-3" for="old">Mật khẩu cũ <span>*</span></label>
                    <input type="password" id="old" name="old-pass">
                    <label class="d-block mt-3" for="new">Mật khẩu mới</label>
                    <input type="password" id="new" name="new-pass">
                    <label class="d-block mt-3" for="confirm">Xác nhận mật khẩu mới</label>
                    <input type="password" id="confirm" name="retype-new-pass">
                    <button type="submit">Lưu thay đổi</button>
                    <div class="error" style="color: #ff4c3b"><%= error != null ? error : ""%>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="text-center mt-5">
        <p>
            <b>Copyright
                <script>document.write(new Date().getFullYear())</script>
                Phần mềm quản lý bán hàng
            </b>
        </p>
    </div>
</main>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/admin-js.jsp"/>
<script>
    function validateFormChangePass() {
        var x = document.forms["form-change-pass"]["old-pass"].value;
        var y = document.forms["form-change-pass"]["new-pass"].value;
        var z = document.forms["form-change-pass"]["retype-new-pass"].value;
        if (x === "" || y === "" || z === "") {
            alert("Hãy nhập đầy đủ thông tin ^.^");
            return false;
        }
    }
</script>
</body>
</html>