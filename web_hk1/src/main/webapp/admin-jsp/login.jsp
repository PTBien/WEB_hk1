<%@ page import="utils.CommonString" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Đăng nhập</title>
    <!-- ===== STYLESHEET ===== -->
    <link rel="stylesheet" href="${context}/admin-assets/css/login.css"/>
    <link rel="stylesheet" href="${context}/admin-assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
</head>

<body>
<% String error = (String) request.getAttribute("error"); %>

<section class="container-login d-flex justify-content-center align-items-center p-3">
    <div class="wrap-login">
        <div class="login-pic">
            <img src="${context}/admin-assets/images/team.jpg" alt="">
        </div>
        <div class="login-form">
            <span class="login-form-title text-center d-block mb-4">ĐĂNG NHẬP HỆ THỐNG</span>
            <form name="form-login" onsubmit="return validateFormLogin()" method="post">
                <%
                    if (error != null) {
                %>
                <div class="alert alert-danger notification" role="alert">
                    <%= error %>
                </div>
                <%
                    }
                %>
                <div class="wrap-input">
                    <input class="input"
                           type="text"
                           value="<%=request.getParameter("username") != null ? request.getParameter("username"):""%>"
                           placeholder="Tài khoản quản trị" name="username" id="field-username">
                    <span class="symbol-input d-flex align-items-center pl-4"><i class='bx bx-user'></i></span>
                </div>
                <div class="wrap-input">
                    <input autocomplete="off" class="input" type="password" placeholder="Mật khẩu" name="password"
                           id="field-password">
                    <span toggle="#field-password" class="bx bx-hide field-icon click-eye"></span>
                    <span class="symbol-input d-flex align-items-center pl-4"><i class='bx bx-key'></i></span>
                </div>
                <div class="form-btn d-flex flex-wrap justify-content-center w-100 pt-3">
                    <input type="submit" value="Đăng nhập" id="btn-login"/>
                </div>
                <div class="text-center pt-3">
                </div>
            </form>
        </div>
        <div class="text-center pt-5 w-100">
            <b>
                Phần mềm quản lý bán hàng <i class="bx bx-copyright"></i>
                <script>document.write(new Date().getFullYear())</script>
            </b>
        </div>
    </div>
</section>

<!-- ====== JAVASCRIPT ===== -->
<script src="${context}/admin-assets/js/bootstrap.min.js"/>
"></script>
<script src="${context}/admin-assets/vendor/jquery/jquery-3.2.1.min.js"/>
"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script>
    function validateFormLogin() {
        var x = document.forms["form-login"]["username"].value;
        var y = document.forms["form-login"]["password"].value;
        if (x == "" || y == "") {
            alert("Hãy nhập đầy đủ thông tin^.^");
            return false;
        }
    }
</script>
<script>
    <c:set var="alert" value="${requestScope.Alert}"/>
    <c:if test="${alert.equals('login_fail')}">
        swal({
            title: "Thông báo",
            text: "Tài khoản của bạn đã bị khóa",
            type: "warning"
        })
    </c:if>
</script>
</body>
</html>
