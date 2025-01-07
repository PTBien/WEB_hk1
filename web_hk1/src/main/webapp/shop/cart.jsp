<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pu" uri="https://com.noithat.functions" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Nội thất Future | Giỏ Hàng</title>
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

<!-- ===== BREADCRUMBS ===== -->
<div class="breadcrumbs py-4">
    <div class="container text-left">
        <ul class="bread-list d-inline-block">
            <li class="d-inline-block text-capitalize"><a href="${context}/shop/home">Trang chủ<i class="ti-arrow-right mx-2"></i></a></li>
            <li class="d-inline-block text-capitalize"><a href="">Giỏ hàng</a></li>
        </ul>
    </div>
</div>

<!-- Empty Cart -->
<%--suppress ELSpecValidationInJSP--%>
<c:if test="${!sessionScope.containsKey('cart') || sessionScope.cart.map.size() == 0}">
    <div class="no-data text-center my-5 in-cart">
        <img src="${context}/shop/images/empty_cart.jpg" alt="No data">
        <p class="mt-3">Không có sản phẩm nào</p>
        <a href="${context}/shop/home" id="btn-cart-buy">Mua ngay</a>
    </div>
</c:if>

<%--suppress ELSpecValidationInJSP--%>
<c:if test="${sessionScope.cart.map.size() > 0}">
    <!-- ===== SHOPPING CART ===== -->
    <div class="shopping-cart">
        <div class="container">
            <table class="table shopping-summery bg-white">
                <thead>
                <tr class="main-hading">
                    <th>SẢN PHẨM</th>
                    <th>TÊN SẢN PHẨM</th>
                    <th class="text-center">GIÁ</th>
                    <th class="text-center">SỐ LƯỢNG</th>
                    <th class="text-center">TỔNG</th>
                    <th class="text-center">
                        <i class="ti-trash remove-icon"></i>
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${sessionScope.cart.map}">
                    <tr data-product-id="${item.key}">
                        <td class="image" data-title="No">
                            <img src="${context}/${item.value.product.imgPath}" alt="#"/>
                        </td>
                        <td class="product-des" data-title="Description">
                            <a data-product-name="${item.value.product.name}"
                               class="product-name" href="${context}/shop/product-details?product_id=${item.key}">${item.value.product.name}</a>
                            <p class="product-des">
                                    <%--                               giuong go tram--%>
                            </p>
                        </td>
                        <td class="price text-center" data-title="Price">
                            <span data-price="${item.value.product.newPrice}">${pu:format(item.value.product.newPrice)}đ</span>
                        </td>
                        <td class="qty" data-title="Qty">
                            <div class="input-group">
                                <div class="button minus">
                                    <button type="button" class="btn btn-primary btn-number"><i class="ti-minus"></i></button>
                                </div>
                                <input type="text" class="input-number" value="${item.value.quantity}"/>
                                <div class="button plus">
                                    <button type="button" class="btn btn-primary btn-number"><i class="ti-plus"></i></button>
                                </div>
                            </div>
                        </td>
                        <td class="total-amount text-center" data-title="Total">
                            <span data-price>${pu:format(item.value.product.newPrice * item.value.quantity)}đ</span>
                        </td>
                        <td class="action text-center" data-title="Remove">
                            <a href="#"><i class="ti-trash remove-icon"></i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Total Amount -->
            <div class="total-amount">
                <div class="row">
                    <div class="col-lg-6 col-md-4 col-12">
                        <p class="last">Tổng trị giá<span>${pu:format(sessionScope.cart.totalPrice)}đ</span></p>
                    </div>
                    <div class="col-lg-3 col-md-4 col-12">
                        <a href="${context}/shop/home" class="btn cont">Tiếp tục mua</a>
                    </div>
                    <div class="col-lg-3 col-md-4 col-12">
                        <a href="${context}/shop/checkout" class="btn buy">Mua hàng</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- ===== SHOP SERVICES ===== -->
<jsp:include page="../common/shop-services.jsp"/>

<!-- ===== FOOTER ===== -->
<jsp:include page="../common/shop-footer.jsp"/>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/shop-js.jsp"/>

<script>
    $('.minus .btn-number').on('click', function () {
        const pId = $(this).closest('tr').attr('data-product-id')
        window.location.href = '${context}/shop/add-to-cart?product_id=' + pId + '&action=remove'
    })

    $('.plus .btn-number').on('click', function () {
        const pId = $(this).closest('tr').attr('data-product-id')
        window.location.href = '${context}/shop/add-to-cart?product_id=' + pId + '&action=add'
    })

    $('.action a').on('click', function () {
        $.alert({
            title: 'Xác nhận xóa',
            content: 'Xóa sản phẩm ' + $(this).closest('tr').find('a[data-product-name]').attr('data-product-name'),
            closeIcon: true,
            animateFromElement: false,
            theme: 'material',
            buttons: {
                login: {
                    text: 'Xóa',
                    btnClass: 'btn-danger',
                    action: () => {
                        const pId = $(this).closest('tr').attr('data-product-id')
                        window.location.href = '${context}/shop/add-to-cart?product_id=' + pId + '&action=delete'
                    }
                }
            }
        })

        return false
    })

    $('.btn.buy').on('click', function () {
        <%--suppress ELSpecValidationInJSP--%>
        const isLogin = Boolean(${sessionScope.containsKey('auth_customer')})
        if (!isLogin) {
            $.alert({
                title: 'Đăng nhập',
                content: 'Vui lòng đăng nhập để mua hàng',
                closeIcon: true,
                animateFromElement: false,
                theme: 'material',
                buttons: {
                    login: {
                        text: 'Đăng nhập',
                        action: () => window.location.href = '${context}/shop/login'
                    }
                }
            })

        } else
            window.location.href = '${context}/shop/checkout'

        return false
    })
</script>
</body>

</html>