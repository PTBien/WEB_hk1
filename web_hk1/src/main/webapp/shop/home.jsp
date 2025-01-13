<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pu" uri="https://com.noithat.functions" %>

<%-- Global variables declaration --%>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Nội thất Future | Trang chủ </title>
    <link rel="icon" type="image/png" href="images/img_logo.png"/>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/shop-css.jsp"/>
</head>

<body>
<!-- ===== PRELOADER ===== -->
<div class="preloader">
    <div class="preloader-inner">
        <div class="preloader-icon">
            <span></span>
            <span></span>
        </div>
    </div>
</div>

<!-- ===== HEADER ===== -->
<jsp:include page="../common/shop-header.jsp"/>

<!-- ===== SLIDER ===== -->
<section class="hero-slider">
    <div class="single-slider">
        <div class="container">
            <div class="row no-gutters">
                <div class="col-lg-8 col-12">
                    <div class="row">
                        <div class="hero-text">
                            <h1>
                                <span>GIẢM ĐẾN 49% </span>  Nội thất Future
                            </h1>
                            <p>
                                Cám ơn vì đã chọn Future
                                Future - nội thất giá rẻ , bạn của mọi nhà
                            </p>
                            <div class="button">
                                <a href="${context}/shop/products" class="btn">Mua Ngay</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== LATEST PRODUCTS ===== -->
<section class="newest-products">
    <div class="container">
        <div class="section-title">
            <h2>Sản phẩm mới nhất</h2>
        </div>
        <div class="owl-carousel newest-slider">
            <c:forEach var="p" items="${requestScope.new_products}">
                <div class="single-product mt-0 mb-0 mr-2 ml-2" data-quantity="${p.quantity}">
                    <div class="product-img">
                        <a href="${context}/shop/product-details?product_id=${p.idProduct}">
                            <img class="default-img" src="${context}${p.imgPath}" alt="#"/>
                            <c:choose>
                                <c:when test="${p.quantity == 0}">
                                    <span class="out">Hết</span>
                                </c:when>
                                <c:when test="${pu:inList(p, requestScope.new_products)}">
                                    <span class="new">Mới</span>
                                </c:when>
                                <c:when test="${pu:inList(p, requestScope.hot_products)}">
                                    <span class="hot">Hot</span>
                                </c:when>
                                <c:when test="${p.oldPrice != p.newPrice}">
                                    <span class="dis">-${pu:discount(p.oldPrice, p.newPrice)}%</span>
                                </c:when>
                            </c:choose>
                        </a>
                        <c:if test="${p.status != 'Cấm Bán'}">
                            <div class="cart-container">
                                <button data-context="${context}" class="btn-cart" data-product-id="${p.idProduct}"><i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng</button>
                            </div>
                        </c:if>
                    </div>
                    <div class="product-content">
                        <a href="${context}/shop/product-details?product_id=${p.idProduct}">${p.name}</a>
                        <div class="rating">
                            <c:forEach begin="1" end="5" varStatus="i">
                                <i class="fa fa-star <c:if test="${i.index <= p.review.average}">yellow</c:if>"></i>
                            </c:forEach>
                        </div>
                        <div class="product-price">
                            <c:if test="${p.oldPrice != p.newPrice}">
                                <span class="old">${pu:format(p.oldPrice)}đ</span>
                            </c:if>
                            <span>${pu:format(p.newPrice)}đ</span>
                        </div>
                    </div>
                    <c:if test="${p.status == 'Cấm Bán'}">
                        <div class="banned">
                            <div class="banned-inner">
                                <span>Cấm bán</span>
                            </div>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ===== TRENDING PRODUCTS ===== -->
<div class="product-area">
    <div class="container">
        <!-- Title -->
        <div class="section-title">
            <h2>Sản phẩm tiêu biểu</h2>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="product-info">
                    <div class="nav-main mb-5">
                        <!-- Tab Nav -->
                        <ul class="nav nav-tabs" role="tablist">
                            <c:forTokens var="tab" items="Sản phẩm, Bộ sưu tập" delims="," varStatus="i">
                                <li class="nav-item d-inline-block">
                                    <a class="nav-link <c:if test="${i.first}">active</c:if>" data-toggle="tab"
                                        <%--suppress ELSpecValidationInJSP--%>
                                       href="#${requestScope['product_map'].keySet().toArray()[i.index]}" role="tab">${tab}</a>
                                </li>
                            </c:forTokens>
                        </ul>
                    </div>
                    <div class="tab-content">
                        <c:forEach var="tpr" items="${requestScope.product_map}" varStatus="i">
                            <div class="tab-pane fade <c:if test="${i.first}">show active</c:if>" id="${tpr.key}" role="tabpanel">
                                <div class="tab-single">
                                    <div class="row mt-0 p-0">
                                        <c:forEach var="p" begin="0" end="7" items="${tpr.value}">
                                            <div class="col-xl-3 col-lg-4 col-md-4 col-12 m-0 p-0">
                                                <div class="single-product mt-2 mb-2 mr-2 ml-2" data-quantity="${p.quantity}">
                                                    <div class="product-img">
                                                        <a href="${context}/shop/product-details?product_id=${p.idProduct}">
                                                            <img class="default-img" src="${context}${p.imgPath}" alt="#"/>
                                                            <c:choose>
                                                                <c:when test="${p.quantity == 0}">
                                                                    <span class="out">Hết</span>
                                                                </c:when>
                                                                <c:when test="${pu:inList(p, requestScope.new_products)}">
                                                                    <span class="new">Mới</span>
                                                                </c:when>
                                                                <c:when test="${pu:inList(p, requestScope.hot_products)}">
                                                                    <span class="hot">Hot</span>
                                                                </c:when>
                                                                <c:when test="${p.oldPrice != p.newPrice}">
                                                                    <span class="dis">-${pu:discount(p.oldPrice, p.newPrice)}%</span>
                                                                </c:when>
                                                            </c:choose>
                                                        </a>
                                                        <c:if test="${p.status != 'Cấm Bán'}">
                                                            <div class="cart-container">
                                                                <button data-context="${context}" class="btn-cart" data-product-id="${p.idProduct}"><i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng</button>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="product-content">
                                                        <a href="${context}/shop/product-details?product_id=${p.idProduct}">${p.name}</a>
                                                        <div class="rating">
                                                            <c:forEach begin="1" end="5" varStatus="i">
                                                                <i class="fa fa-star <c:if test="${i.index <= p.review.average}">yellow</c:if>"></i>
                                                            </c:forEach>
                                                        </div>
                                                        <div class="product-price">
                                                            <c:if test="${p.oldPrice != p.newPrice}">
                                                                <span class="old">${pu:format(p.oldPrice)}đ</span>
                                                            </c:if>
                                                            <span>${pu:format(p.newPrice)}đ</span>
                                                        </div>
                                                    </div>
                                                    <c:if test="${p.status == 'Cấm Bán'}">
                                                        <div class="banned">
                                                            <div class="banned-inner">
                                                                <span>Cấm bán</span>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ===== SHOP HOME LIST =====  -->
<section class="shop-home-list">
    <div class="container">
        <div class="row">
            <c:forEach begin="1" end="3" varStatus="i">
                <div class="col-lg-4 col-md-6 col-12">
                    <div class="shop-list-title">
                        <h1>
                            <c:choose>
                                <c:when test="${i.count == 1}">Giảm giá</c:when>
                                <c:when test="${i.count == 2}">Bán chạy</c:when>
                                <c:when test="${i.count == 3}">Xem nhiều</c:when>
                            </c:choose>
                        </h1>
                    </div>
                    <c:choose>
                        <c:when test="${i.count == 1}">
                            <c:set var="items" value="${requestScope.discount_products}"/>
                        </c:when>
                        <c:when test="${i.count == 2}">
                            <c:set var="items" value="${requestScope.selling_products}"/>
                        </c:when>
                        <c:when test="${i.count == 3}">
                            <c:set var="items" value="${requestScope.view_products}"/>
                        </c:when>
                    </c:choose>
                    <c:forEach var="p" begin="0" end="2" items="${items}">
                        <div class="single-list">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-12">
                                    <div class="list-image">
                                        <a href="${context}/shop/product-details?product_id=${p.idProduct}"><img src="${context}${p.imgPath}" alt="#"/></a>
                                        <a href="${context}/shop/product-details?product_id=${p.idProduct}" class="buy"><i
                                                class="fa fa-shopping-bag"></i></a>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-12">
                                    <div class="content pt-5">
                                        <a class="pname" href="${context}/shop/product-details?product_id=${p.idProduct}">${p.name}</a>
                                        <p class="price">${pu:format(p.newPrice)}đ</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ===== COUNTDOWN ===== -->
<c:set var="tp" value="${requestScope['today_discount_product']}"/>
<c:if test="${tp != null}">
    <section class="countdown">
        <div class="container-fluid p-0 h-100">
            <div class="row h-100 m-0">
                <div class="col-lg-5 col-12 h-100 m-0 p-0">
                    <div class="image h-100">
                        <img src="${context}/${tp.imgPath}" alt="#"/>
                    </div>
                </div>
                <div class="col-lg-7 col-12 h-100 m-0 p-0">
                    <div class="content">
                        <div class="heading-block">
                            <p class="small-title">Giảm giá trong ngày</p>
                            <h3 class="title"><a href="${context}/shop/product-details?product_id=${tp.idProduct}">${tp.name}</a></h3>
                            <p class="p-desc">${tp.desc}</p>
                            <h1 class="price">${pu:format(tp.newPrice)}đ <s>${pu:format(tp.oldPrice)}đ</s></h1>
                            <div class="time-container my-4 d-flex justify-content-center">
                                <c:forTokens var="time" items="hours,minutes,seconds" delims="," varStatus="i">
                                    <div class="time-block">
                                        <span class="time-${time}"></span>
                                        <span>${time}</span>
                                    </div>
                                    <c:if test="${!i.last}"><span class="time-delim">:</span></c:if>
                                </c:forTokens>
                            </div>
                            <button class="get-now">MUA NGAY</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</c:if>

<!-- ===== SHOP BLOG =====  -->
<section class="shop-blog">
    <div class="container">
        <div class="section-title">
            <h2>Tin mới nhất</h2>
        </div>

        <div class="row">
            <div class="col-lg-4 col-md-6 col-12">
                <div class="shop-single-blog">
                    <a href="blog.jsp"><img src="../images/tin_tuc/370x300/tin_01.jpg" alt="#"/></a>
                    <div class="content p-4">
                        <p class="date">Thứ Hai, ngày 30/9/2022</p>
                        <a href="blog.jsp" class="title">Bộ Hóa chất áp giá các sản phẩm được nhập khẩu từ Mỹ...</a>
                        <a href="blog.jsp" class="more-btn">Tiếp tục đọc</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-12">
                <div class="shop-single-blog">
                    <a href="blog.jsp"><img src="../images/tin_tuc/370x300/tin_02.jpg" alt="#"/></a>
                    <div class="content p-4">
                        <p class="date">Thứ Ba, ngày 31/9/2022</p>
                        <a href="blog.jsp" class="title">Công bố chương trình khuyến mãi sản phẩm cho thí nghiệm...</a>
                        <a href="blog.jsp" class="more-btn">Tiếp tục đọc</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-12">
                <div class="shop-single-blog">
                    <a href="blog.jsp"><img src="../images/tin_tuc/370x300/tin_03.jpg" alt="#"/></a>
                    <div class="content p-4">
                        <p class="date">Chủ Nhật, ngày 29/9/2022</p>
                        <a href="blog.jsp" class="title">Tổ chức huy hoạch 200 hecta đất để xây dựng nhà máy chế...</a>
                        <a href="blog.jsp" class="more-btn">Tiếp tục đọc</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== SHOP SERVICES -->
<jsp:include page="../common/shop-services.jsp"/>

<!-- ===== FOOTER ===== -->
<jsp:include page="../common/shop-footer.jsp"/>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/shop-js.jsp"/>

<script>
    const height = $(window).height() - $('.header.shop').height()
    $('.single-slider').height(height)

    /* [ Add To Cart ]
    -------------------------------------------- */
    $('.btn-cart').on('click', function () {
        const quantity = Number($(this).closest('.single-product').attr('data-quantity'))
        if (quantity === 0) {
            $.alert({
                title: 'Hết hàng',
                content: 'Số lượng sản phẩm không đủ.',
                closeIcon: true,
                animateFromElement: false,
                theme: 'material'
            })
        } else {
            const pId = $(this).attr('data-product-id')
            window.location.href = $(this).attr('data-context') + '/shop/add-to-cart?product_id=' + pId
        }
    })
</script>
</body>

</html>