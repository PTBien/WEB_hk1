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
    <title>Nội thất Future| Lịch Sử Mua Hàng</title>
    <link rel="icon" type="image/png" href="${context}/shop/images/img_logo.png"/>

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
            <li class="d-inline-block text-capitalize">
                <a href="${context}/shop/home">Trang chủ</a>
                <i class="ti-arrow-right mx-2"></i>
            </li>
            <li class="d-inline-block text-capitalize">
                <a href="${context}/shop/profile">Hồ sơ của tôi</a>
                <i class="ti-arrow-right mx-2"></i>
            </li>
            <li class="d-inline-block text-capitalize">
                <a href="">Lịch sử mua hàng</a>
            </li>
        </ul>
    </div>
</div>

<!-- ===== ORDER HISTORY ===== -->
<section id="purchase-history" class="m-0">
    <div class="container">
        <div class="container order-tab d-flex justify-content-between mb-5 p-0">
            <button class="order-tab-links active" data-tab="#all_orders">Tất cả</button>
            <button class="order-tab-links" data-tab="#progress_orders">Đang xử lý</button>
            <button class="order-tab-links" data-tab="#transport_orders">Vận chuyển</button>
            <button class="order-tab-links" data-tab="#completed_orders">Đã giao</button>
            <button class="order-tab-links" data-tab="#canceled_orders">Đã hủy</button>
        </div>
    </div>
    <div id="order-tab-contents" class="mt-5">
        <c:forTokens var="tab" items="all_orders,progress_orders,transport_orders,completed_orders,canceled_orders" delims=",">
            <div class="container bg-white order-tab-content" id="${tab}">
                    <%--suppress ELSpecValidationInJSP--%>
                <c:set var="order_items" value="${requestScope.get(tab)}"/>
                        <c:if test="${empty order_items}">
                            <div class="empty-order w-100 d-flex align-items-center justify-content-center">
                                <div class="text-center">
                                    <img src="${context}/shop/images/empty_order.png" alt="empty-order.png">
                                    <p>Chưa có đơn hàng</p>
                                </div>
                            </div>
                        </c:if>
                <c:forEach var="order" items="${order_items}" varStatus="i">
                    <c:choose>
                        <c:when test="${order.status == 'Đã giao'}"><c:set var="bg" value="bought"/></c:when>
                        <c:when test="${order.status == 'Đang vận chuyển'}"><c:set var="bg" value="transporting"/></c:when>
                        <c:when test="${order.status == 'Đã hủy'}"><c:set var="bg" value="canceled"/></c:when>
                        <c:when test="${order.status == 'Chờ xử lý'}"><c:set var="bg" value="progressing"/></c:when>
                    </c:choose>
                    <div data-order-id="${order.id}" class="item <c:if test="${!i.last}">mb-5</c:if>">
                        <div class="item-header w-100 px-4 py-3 d-flex justify-content-between align-items-center">
                            <div>
                                <span class="span-id mr-4">#${order.id}</span>
                                <span class="supplier">
                            <i class="fa fa-calendar-o mr-1"></i>
                            <span class="d-inline-block pt-2">${pu:formatTime(order.orderTime)}</span>
                        </span>
                            </div>
                            <span class="status ${bg}">${order.status}</span>
                        </div>
                        <div class="item-body w-100 px-4 py-3">
                            <c:forEach var="item" items="${order.items}" varStatus="ii">
                                <div class="sub-item row h-100 no-gutters <c:if test="${!ii.last}">pb-3</c:if>
                                    <c:if test="${!ii.first}">pt-3</c:if>">
                                    <div class="col-lg-6 d-flex align-content-start">
                                        <div class="image-thumbnail mr-3 d-flex align-items-center">
                                            <a href="${context}/shop/product-details?product_id=${item.product.idProduct}">
                                                <img src="${context}/${item.product.imgPath}" alt="">
                                            </a>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <div class="details">
                                                <a class=item-name
                                                   href="${context}/shop/product-details?product_id=${item.product.idProduct}">
                                                        ${item.product.name}
                                                </a>
                                                <p>Phân loại: ${item.product.subtype}</p>
                                                <span>X${item.quantity}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 d-flex justify-content-start align-items-center">
                                        <div class="just-for-centering">
                                            <c:choose>
                                                <c:when test="${item.product.review.totals == 0}">
                                                    <span class="no-rating">Không có đánh giá nào</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="rating-number">${item.product.review.average}<span>/5</span></div>
                                                    <div class="stars">
                                                        <c:forEach begin="1" end="5" varStatus="i">
                                                            <i class="fa fa-star
                                            <c:if test="${i.index <= item.product.review.average}">yellow</c:if>"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="rating-count">${item.product.review.totals} đánh giá</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-end align-items-center col-lg-2 p-0">
                            <span class="price">
                                <span>${pu:format(item.product.oldPrice)}đ</span> ${pu:format(item.product.newPrice)}đ
                            </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="item-footer p-4 d-flex justify-content-between align-items-center">
                            <div class="total"><i class="fa fa-dollar"></i> Thành tiền: <span> ${pu:format(order.total)}đ</span>
                            </div>
                            <div class="action">
                                <c:choose>
                                    <c:when test="${bg == 'progressing'}">
                                        <button class="button-rebuy">Mua Tiếp</button>
                                        <button class="button-cancel ml-2">Hủy</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="button-rebuy">Mua Lại</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:forTokens>
    </div>
</section>

<!-- ===== SHOP SERVICES ===== -->
<jsp:include page="../common/shop-services.jsp"/>

<!-- ===== FOOTER ===== -->
<jsp:include page="../common/shop-footer.jsp"/>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/shop-js.jsp"/>

<script>
    $('.button-cancel').on('click', function () {
        const _this = $(this);
        $.alert({
            title: 'Xác nhận hủy đơn hàng',
            content: 'Bạn có muốn hủy đơn hàng này không?',
            closeIcon: true,
            animateFromElement: false,
            theme: 'material',
            buttons: {
                cancel: {
                    text: 'Đồng ý',
                    btnClass: 'btn-danger',
                    action: () => {
                        const form = $('<form></form>').attr('method', 'post')
                            .attr('action', '${context}/shop/profile/order-history')
                        const field = $('<input>').attr('type', 'hidden').attr('name', 'cancel')
                            .attr('value', $(_this).closest('.item').attr('data-order-id'))
                        $(document.body).append(form.append(field))
                        form.submit()
                    }
                },
                no: {
                    text: 'Không'
                }
            }
        })
    })

    $('.button-rebuy').on('click', function () {
        window.location.href =
            '${context}/shop/profile/order-history?order_id=' + $(this).closest('.item').attr('data-order-id')
    })
</script>

<script>
    $('.order-tab-content').first().css('display', 'block')

    $('.order-tab-links').on('click', function () {
        $('.order-tab-content').css('display', 'none')
        $($(this).attr('data-tab')).css('display', 'block')
        $('.order-tab-links').removeClass('active')
        $(this).addClass('active')
    })
</script>
</body>

</html>