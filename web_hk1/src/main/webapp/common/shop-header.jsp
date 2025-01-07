<%@ page import="model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="context" value="${pageContext.request.contextPath}"/>
<%Customer customer = (Customer) session.getAttribute("auth_customer");%>
<header class="header shop">
    <div class="topbar">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 col-md-7 col-12">
                    <div class="text-left">
                        <ul>
                            <li><i class="ti-headphone-alt"></i>0978903360</li>
                            <li><i class="fa fa-envelope-o"></i>20130446@st.hcmuaf.edu.vn</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-5 col-md-5 col-12">
                    <div class="text-right">
                        <%if (customer == null) {%>
                        <ul>
                            <li>
                                <a href="${context}/shop/login"><i class="bi bi-box-arrow-in-right"></i>Đăng nhập</a>
                            </li>
                            <li>
                                <a href="${context}/shop/register"><i class="bi bi-person-plus"></i>Đăng ký</a>
                            </li>
                        </ul>
                        <%} else {%>
                        <ul>
                            <li>
                                <a href="${context}/shop/profile_customer">
                                    <i class="bi bi-person-plus"></i>Xin chào <%=customer.getFullname()%>
                                </a>
                            </li>
                            <li>
                                <a href="${context}/shop/DoLogoutCustomer">
                                    <i class="bi bi-box-arrow-in-right"></i>Đăng xuất
                                </a>
                            </li>
                        </ul>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ===== HEADER MIDDLE ====== -->
    <div class="header-middle py-4">
        <div class="container">
            <div class="row">
                <div class="col-lg-2 col-md-2 col-12">
                    <!-- Logo -->
                    <div class="logo">
                        <a href="${context}/shop/home"><img src="${context}/shop/images/img_logo.png" alt="logo"/></a>
                    </div>
                    <!-- Search Mobile -->
                    <div class="mobile-search">
                        <form class="search-form">
                            <input type="text" placeholder="Tìm kiếm..." name="search"/>
                            <button value="search" type="submit">
                                <i class="ti-search"></i>
                            </button>
                        </form>
                        <div>
                            <a href="#"><i class="ti-search"></i></a>
                        </div>
                    </div>
                    <div class="mobile-nav"></div>
                </div>
                <div class="col-lg-8 col-md-7 col-12 pt-1">
                    <div class="search-bar-top">
                        <div class="search-bar" tabindex="1">
                            <form action="${context}/shop/products">
                                <input name="search" placeholder="Nhập tên sản phẩm....." value="${param.search}"/>
                                <button type="submit" class="btn-search">
                                    <i class="ti-search"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-12">
                    <div class="right-bar">
                        <!-- Search Form -->
                        <div class="right-bar-item shopping d-inline-block mr-4">
                            <a href="${context}/shop/cart" class="single-icon">
                                <i class="fa fa-shopping-cart"></i>
                                <c:set var="cartItems" value="${sessionScope.cart.count}"/>
                                <c:if test="${cartItems > 0}">
                                <span class="total-count">${cartItems}</span></a>
                            </c:if>
                        </div>
                        <div class="right-bar-item d-inline-block ">
                            <a href="${context}/shop/profile_customer" class="single-icon">
                                <%if (customer != null) {%>
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                <%} %>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== HEADER MENU ===== -->
    <div class="header-menu" data-context="${context}">
        <div class="container">
            <nav class="navbar navbar-expand-lg p-0">
                <div class="navbar-collapse">
                    <ul class="nav menu navbar-nav">
                        <li class="position-relative mr-2">
                            <a href="#" data-t="1">Sản phẩm<i class="ti-angle-down"></i></a>
                            <ul class="dropdown">
                                <li><a href="#" data-st="1">Phòng Khách</a></li>
                                <li><a href="#" data-st="2">Phòng Ăn</a></li>
                                <li><a href="#" data-st="3">Tủ Bếp</a></li>
                                <li><a href="#" data-st="4">Phòng Ngủ</a></li>
                                <li><a href="#" data-st="5">Phòng Làm Việc</a></li>
                                <li><a href="#" data-st="6">Đồ Trang Trí</a></li>
                            </ul>
                        </li>
                        <li class="position-relative mr-2">
                            <a href="#" data-t="2">Bộ Sưu Tập Mới</a>
<%--                            <ul class="dropdown">--%>
<%--                                <li><a href="#" data-st="10">GRENAA COLLECTION</a></li>--%>
<%--                                <li><a href="#" data-st="11">UBEDA COLLECTION</a></li>--%>
<%--                                <li><a href="#" data-st="12">NARVIK COLLECTION</a></li>--%>
<%--                            </ul>--%>
                        </li>

                        <li class="position-relative mr-2">
                            <a href="${context}/shop/blog.jsp">Tin tức</a>
                        </li>
                        <li class="position-relative">
                            <a href="${context}/shop/contact.jsp">Liên hệ</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
    </div>
</header>