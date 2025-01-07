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
    <title>Nội thất Future | Chi tiết sản phẩm</title>
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
            <li class="d-inline-block text-capitalize"><a href="${context}/shop/product-details">Chi tiết sản phẩm</a></li>
        </ul>
    </div>
</div>

<c:set var="p" value="${requestScope['product']}"/>
<!-- ===== PRODUCT DETAIL ===== -->
<section class="product-detail mt-5">
    <div class="container">
        <div class="row no-gutters main-detail p-5">
            <div class="col-lg-5 col-md-12 col-sm-12 col-xs-12">
                <div class="product-slider">
                    <div class="product-image">
                        <img class="active" src="${context}/${p.imgPath}" alt="">
                    </div>
                    <ul class="image-list">
                        <li><img src="${context}/${p.imgPath}" alt=""></li>
                        <li><img src="${context}/${p.imgPath}" alt=""></li>
                        <li><img src="${context}/${p.imgPath}" alt=""></li>
                        <li><img src="${context}/${p.imgPath}" alt=""></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-7 col-md-12 col-sm-12 col-xs-12">
                <div class="product-d-content pl-5">
                    <span class="supplier d-inline-block mb-1"><i class="bi bi-patch-check-fill"></i> Nhà cung cấp: ${p.supply}</span>
                    <h2 class="pd-name">${p.name}</h2>
                    <div class="product-rating d-flex">
                        <div class="rating">
                            <c:forEach begin="1" end="5" varStatus="i">
                                <i class="fa fa-star <c:if test="${i.index <= p.review.average}">yellow</c:if>"></i>
                            </c:forEach>
                        </div>
                        <a href="#"> (${p.review.totals} Đánh Giá)</a>
                        <span>${p.sold} Đã Bán</span>
                        <span>${p.views} Đã Xem</span>
                    </div>
                    <div class="ps d-flex justify-content-between align-items-center">
                        <h3 class="the-price">${pu:format(p.newPrice)}đ<c:if test="${p.oldPrice != p.newPrice}">
                            <span class="dp">${pu:format(p.oldPrice)}đ</span>
                            <span class="percent">-${pu:discount(p.oldPrice, p.newPrice)}%</span></c:if>
                        </h3>
                        <c:choose>
                            <c:when test="${p.status == 'Cấm bán'}"><span class="label label-forbidden">Cấm bán</span></c:when>
                            <c:when test="${p.quantity == 0}"><span class="label label-out-stock">Hết hàng</span></c:when>
                            <c:otherwise><span class="label label-in-stock">Còn hàng</span></c:otherwise>
                        </c:choose>
                    </div>
                    <div class="product-paragraph">
                        <p>${p.desc}</p>
                    </div>
                    <div class="quantity d-inline-block mr-3">
                        <div class="input-group mt-3">
                            <div class="button minus">
                                <button type="button" class="btn btn-primary btn-number"><i class="ti-minus"></i></button>
                            </div>
                            <input type="text" class="input-number" value="1"/>
                            <div class="button plus">
                                <button type="button" class="btn btn-primary btn-number"><i class="ti-plus"></i></button>
                            </div>
                        </div>
                    </div>
                    <c:if test="${p.status != 'Cấm bán'}">
                        <div class="add-to-cart d-inline-block mt-3">
                            <a href="#" class="btn"><i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng</a>
                        </div>
                    </c:if>
                    <div class="product-stock">
                        <span>${p.quantity} sản phẩm có sẵn</span>
                    </div>
                    <div class="share-social mt-3">
                        <span class="label-share">Chia sẻ</span>
                        <ul class="wrapper">
                            <c:forTokens var="ss" items="facebook,twitter,youtube,instagram" delims="," varStatus="i">
                                <li class="icon ${ss}">
                                    <span class="tooltip">${ss}</span>
                                    <span><i class="fa fa-${ss}<c:if test="${i.first}">-f</c:if><c:if test="${i.count eq 3}">-play</c:if>"></i></span>
                                </li>
                            </c:forTokens>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== REVIEW ===== -->
<section class="product-reviews m-5" id="product-reviews">
    <div class="container">
        <div class="row no-gutters">
            <span class="rating-title">Đánh giá và nhận xét từ khách hàng về ${p.name}</span>
            <div class="col-lg-3">
                <div class="rating-left h-100 d-flex align-items-center">
                    <div>
                        <span class="rating-number">${p.review.average}<span>/5</span></span>
                        <div class="rating-stars">
                            <c:forEach begin="1" end="5" varStatus="i">
                                <i class="fa fa-star <c:if test="${i.index <= p.review.average}">yellow</c:if>"></i>
                            </c:forEach>
                        </div>
                        <span class="num-ratings">${p.review.totals} đánh giá</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="rating-right">
                    <div class="rating-5 row p-1">
                        <div class="col-lg-2">
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                        </div>
                        <div class="col-lg-10 d-flex align-items-center pl-0">
                            <div class="rate-outer">
                                <div class="rate-inner" data-rate="${p.review.percent5}"></div>
                            </div>
                            <div class="rating-count">${p.review.fiveStars}</div>
                        </div>
                    </div>
                    <div class="rating-4 row p-1">
                        <div class="col-lg-2">
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star"></i>
                        </div>
                        <div class="col-lg-10 d-flex align-items-center pl-0 w-100">
                            <div class="rate-outer">
                                <div class="rate-inner" data-rate="${p.review.percent4}"></div>
                            </div>
                            <div class="rating-count">${p.review.fourStars}</div>
                        </div>
                    </div>
                    <div class="rating-3 row p-1">
                        <div class="col-lg-2">
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                        </div>
                        <div class="col-lg-10 d-flex align-items-center pl-0">
                            <div class="rate-outer">
                                <div class="rate-inner" data-rate="${p.review.percent3}"></div>
                            </div>
                            <div class="rating-count">${p.review.threeStars}</div>
                        </div>
                    </div>
                    <div class="rating-2 row p-1">
                        <div class="col-lg-2">
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                        </div>
                        <div class="col-lg-10 d-flex align-items-center pl-0">
                            <div class="rate-outer">
                                <div class="rate-inner" data-rate="${p.review.percent2}"></div>
                            </div>
                            <div class="rating-count">${p.review.twoStars}</div>
                        </div>
                    </div>
                    <div class="rating-1 row p-1">
                        <div class="col-lg-2">
                            <i class="fa fa-star yellow"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                        </div>
                        <div class="col-lg-10 d-flex align-items-center pl-0">
                            <div class="rate-outer">
                                <div class="rate-inner" data-rate="${p.review.percent1}"></div>
                            </div>
                            <div class="rating-count">${p.review.oneStars}</div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="btn-rating">Đánh giá ngay</button>
        </div>
    </div>
</section>

<!-- ===== RATING MODAL ===== -->
<div id="rating-modal" class="hidden">
    <div class="modal-content">
        <span class="close"><i class="bi bi-x-lg"></i></span>
        <form action="${context}/shop/product-details?product_id=${p.idProduct}" method="POST" id="rating-form" class="position-relative h-100">
            <h5>Đánh giá ${p.name}</h5>
            <div class="content-comment">
                <textarea name="content" id="rating-content" rows="6" placeholder="Mời bạn chia sẻ thêm một số cảm nhận..."></textarea>
                <div class="error hidden">Nội dung bình luận là bắt buộc!</div>
            </div>
            <div class="row no-gutters my-4 d-flex align-items-center">
                <div class="col-lg-4">
                    <p class="feeling">Bạn cảm thấy thế<br>nào về sản phẩm?<br>(Chọn sao)</p>
                </div>
                <div class="col-lg-8">
                    <div class="star-wrapper">
                        <input type="hidden" name="stars" value="5" id="input-stars">
                        <c:forTokens var="span" items="Tuyệt vời,Tốt,Trung bình,Không tệ,Rất tệ" delims="," varStatus="i">
                            <div class="star <c:if test="${i.first}">active</c:if>" data-star="${6 - i.count}">
                                <i class="fa fa-star"></i>
                                <span>${span}</span>
                            </div>
                        </c:forTokens>
                    </div>
                </div>
            </div>
            <div class="rating-info d-flex justify-content-between mb-4">
                <div class="w-100 mr-3">
                    <input type="text" placeholder="Họ tên" name="fullname" id="rating-name">
                    <span class="error hidden mt-2">Tên là bắt buộc!</span>
                </div>
                <div class="w-100">
                    <input type="text" placeholder="Số điện thoại" name="phone" id="rating-phone">
                    <span class="error hidden mt-2">Số điện thoại là bắt buộc!</span>
                </div>
                <div class="w-100 ml-3">
                    <input type="text" placeholder="Email" name="email" id="rating-email">
                </div>
            </div>
            <button type="button" id="btn-send-rating">Gửi đánh giá</button>
            <p class="d-block m-0 condition"><u>Lưu ý:</u> Để đánh giá được phê duyệt, vui lòng tham khảo
                <a href="#">Điều khoản và Chính sách bảo mật</a>
            </p>
        </form>
    </div>
</div>

<!-- ===== RELATED PRODUCTS ===== -->
<section class="newest-products mb-5">
    <div class="container">
        <div class="section-title">
            <h2>Sản Phẩm Liên Quan</h2>
        </div>
        <div class="owl-carousel newest-slider">
            <c:forEach var="pr" items="${requestScope.related_products}">
                <div class="single-product mt-0 mb-0 mr-2 ml-2" data-quantity="${pr.quantity}">
                    <div class="product-img">
                        <a href="${context}/shop/product-details?product_id=${pr.idProduct}">
                            <img class="default-img" src="${context}/${pr.imgPath}" alt="#"/>
                            <c:choose>
                                <c:when test="${pr.quantity == 0}">
                                    <span class="out">Hết</span>
                                </c:when>
                                <c:when test="${pu:inList(pr, requestScope.new_products)}">
                                    <span class="new">Mới</span>
                                </c:when>
                                <c:when test="${pu:inList(pr, requestScope.hot_products)}">
                                    <span class="hot">Hot</span>
                                </c:when>
                                <c:when test="${pr.oldPrice != pr.newPrice}">
                                    <span class="dis">-${pu:discount(pr.oldPrice, pr.newPrice)}%</span>
                                </c:when>
                            </c:choose>
                        </a>
                        <div class="cart-container">
                            <button data-context="${context}" class="btn-cart" data-product-id="${pr.idProduct}"><i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng</button>
                        </div>
                    </div>
                    <div class="product-content">
                        <a href="${context}/shop/product-details?product_id=${pr.idProduct}">${pr.name}</a>
                        <div class="rating">
                            <c:forEach begin="1" end="5" varStatus="i">
                                <i class="fa fa-star <c:if test="${i.index <= pr.review.average}">yellow</c:if>"></i>
                            </c:forEach>
                        </div>
                        <div class="product-price">
                            <c:if test="${pr.oldPrice != pr.newPrice}">
                                <span class="old">${pu:format(pr.oldPrice)}đ</span>
                            </c:if>
                            <span>${pu:format(pr.newPrice)}đ</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
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
    $('.image-list img').on('mouseover', function () {
        $('.product-image .active').attr('src', $(this).attr('src'))
    })

    $('.rate-inner').each(function () {
        $(this).css('width', $(this).attr('data-rate').concat('%'))
    })

    $('.btn-rating').on('click', function () {
        $('#rating-modal').removeClass('hidden')
        $('body').css('overflow', 'hidden')
    })

    $('span.close').on('click', () => {
        const ratingMd = $('#rating-modal');
        ratingMd.addClass('hidden')
        ratingMd.animate({bottom: '1000px'})
        $('body').css('overflow', 'auto')
    })

    window.onclick = function (event) {
        close(event)
    }

    function close(event) {
        if (event.target === document.getElementById('rating-modal')) {
            $('#rating-modal').addClass('hidden')
            $('body').css('overflow', 'auto')
        }
    }

    window.onclick = function (event) {
        if (event.target === document.getElementById('rating-modal')) {
            $('#rating-modal').addClass('hidden')
            $('body').css('overflow', 'auto')
        }
    }

    const starDiv = $('.star-wrapper .star');
    let el = starDiv.first();
    starDiv.on('click', function () {
        $('#input-stars').val($(this).attr('data-star'))
        toggleStar(el = $(this))
    })

    starDiv.mouseover(e => toggleStar($(e.target)))
    starDiv.mouseout(e => toggleStar(el))

    function toggleStar(e) {
        starDiv.each(function () {
            $(this).removeClass('active')
        })
        e.addClass('active')
    }

    if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }

    $('#btn-send-rating').on('click', function () {
        let isValid = true;
        if ($('#rating-content').val() === "") {
            $('.content-comment .error').removeClass('hidden')
            isValid = false
        }

        if ($('#rating-name').val() === "") {
            $('#rating-name ~ .error').removeClass('hidden')
            isValid = false
        }

        if ($('#rating-phone').val() === "") {
            $('#rating-phone ~ .error').removeClass('hidden')
            isValid = false
        }

        if (!isValid) return false
        else $('#rating-form').submit()
    })

    $('.product-rating a').click(function () {
        $('html, body').animate({
            scrollTop: $('#product-reviews').offset().top - 250
        }, 1000);
    });

    $('.add-to-cart a').on('click', function () {
        const remainQuantity = Number(${p.quantity}), quantity = $('.quantity .input-number').val()
        if (remainQuantity === 0 || remainQuantity < quantity) {
            $.alert({
                title: 'Hết hàng',
                content: 'Số lượng sản phẩm không đủ.',
                closeIcon: true,
                animateFromElement: false,
                theme: 'material'
            })
        } else {
            window.location.href =
                '${context}/shop/add-to-cart?product_id=${p.idProduct}' + '&action=add' + '&quantity=' + quantity
        }

        return false
    })

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