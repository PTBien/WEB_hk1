<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Nội thất Future| Quên Mật Khẩu</title>
    <link rel="icon" type="image/png" href="images/img_logo.png"/>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/shop-css.jsp"/>
</head>

<body>
<!-- ===== HEADER ===== -->
<header class="header-account">
    <div class="container">
        <div class="row py-3">
            <div class="col-lg-7 col-md-7 col-12">
                <div class="title-left d-flex justify-content-start h-100 align-items-center">
                    <a class="w-25 mr-4" href="${context}/shop/home"><img src="images/img_logo.png" alt=""/></a>
                    <span class="d-inline-block mt-1">Quên Mật Khẩu</span>
                </div>
            </div>
            <div class="col-lg-5 col-md-5 col-12">
                <div class="title-right d-flex h-100 justify-content-end align-items-center">
                    <a href="#">Bạn cần giúp đỡ?</a>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- ===== BREADCRUMBS ===== -->
<div class="breadcrumbs py-4">
    <div class="container text-left">
        <ul class="bread-list d-inline-block">
            <li class="d-inline-block text-capitalize"><a href="${context}/shop/home">Trang chủ<i class="ti-arrow-right mx-2"></i></a></li>
            <li class="d-inline-block text-capitalize"><a href="">Quên mật khẩu</a></li>
        </ul>
    </div>
</div>

<!-- ===== FORM INPUT ===== -->
<%String error = (String)request.getAttribute("error_forgot");%>
<%String success = (String)request.getAttribute("success_forgot");%>
<section class="form-input py-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 col-md-7 col-12 text-center">
                <img width="80%" src="images/labs/login_start.jpg" alt=""/>
            </div>
            <div class="col-lg-5 col-md-5 col-12">
                <div class="h-100 d-flex align-items-center">
                    <form class="m-0 p-5 text-center" action="${context}/shop/forgot-password" method="post">
                        <h5 class="mb-4">Quên Mật Khẩu</h5>
                        <%if(error != null){%>
                        <div class="w-100 mb-3 alert alert-danger notification" role="alert">
                            <%=error%>
                        </div>
                        <%}%>
                        <%if(success != null){%>
                        <div class="w-100 mb-3 alert alert-success notification" role="alert">
                            <%=success%>
                        </div>
                        <%}%>
                        <input class="w-100 mb-4" type="text" placeholder="Email" name="email"
                               value="<%=request.getParameter("email") != null ? request.getParameter("email") : ""%>"/>
                        <button type="submit" class="btn next w-100 mb-3">Xác nhận</button>
                        <span class="shotcut">
                                <a class="mr-3" href="${context}/shop/login">Đăng nhập?</a>
                                <a href="${context}/shop/register">Đăng ký?</a></span>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== SHOP SERVICES ===== -->
<jsp:include page="../common/shop-services.jsp"/>

<!-- ===== FOOTER ===== -->
<jsp:include page="../common/shop-footer.jsp"/>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/shop-js.jsp"/>

</body>

</html>