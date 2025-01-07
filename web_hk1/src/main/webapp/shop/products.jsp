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
    <title>Nội thất Future | Sản phẩm</title>
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
            <li class="d-inline-block text-capitalize">
                <a href="${context}/shop/home">Trang chủ</a>
                <i class="ti-arrow-right mx-2"></i>
            </li>
            <li class="d-inline-block text-capitalize">
                <a href="${context}/shop/products">Danh sách sản phẩm</a>
                <c:if test="${requestScope.bc_t != null}"><i class="ti-arrow-right mx-2"></i></c:if>
            </li>
            <c:if test="${requestScope.bc_t != null}">
                <li class="d-inline-block text-capitalize">
                    <a href="${context}/shop/products?type=${param.type}">${requestScope.bc_t}</a>
                    <c:if test="${requestScope.bc_st != null}"><i class="ti-arrow-right mx-2"></i></c:if>
                </li>
            </c:if>
            <c:if test="${requestScope.bc_st != null}">
                <li class="d-inline-block text-capitalize">
                    <a href="">${requestScope.bc_st}</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>

<!-- ===== PRODUCTS ===== -->
<section class="products">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-4 col-12">
                <div class="shop-sidebar">
                    <c:if test="${param.search == null}">
                        <!-- Category -->
                        <div class="single-widget category mb-4">
                            <h3 class="title">Phân loại</h3>
                            <ul class="category-list">
                                <c:forEach var="es" items="${requestScope.subtypes}">
                                    <li class="<c:if test="${param['subtype'] == es.key}">click-active</c:if>">
                                        <i class="fa fa-caret-right mr-2"></i>
                                        <a data-select="subtype" data-query="${es.key}">${es.value}</a>
                                    </li>
                                </c:forEach>
                                <c:forEach var="es" items="${sessionScope.all_products}">
                                    <li>
                                        <i class="fa fa-caret-right mr-2"></i>
                                        <a data-select="type" data-query="${es.key}">${es.value}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <!-- Supplier -->
                    <div class="single-widget category mb-4">
                        <h3 class="title">Nhà cung cấp</h3>
                        <ul class="category-list">
                            <c:forEach var="spl" items="${requestScope.suppliers}">
                                <li class="<c:if test="${param['supplier'] == spl.key}">click-active</c:if>">
                                    <i class="fa fa-caret-right mr-2"></i>
                                    <a data-select="supplier" data-query="${spl.key}">${spl.value}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <!-- Price Filter -->
                    <div class="single-widget range">
                        <h3 class="title">Lọc theo giá</h3>
                        <div class="label-input mt-3">
                            <div class="d-flex justify-content-around">
                                <c:set var="from" value="${param['minPrice']}"/>
                                <c:set var="to" value="${param['maxPrice']}"/>
                                <input class="from w-100 bg-white" type="text" placeholder="TỪ" value="${from}">
                                <div class="divider-dash mx-2 d-flex align-items-center">
                                    <div></div>
                                </div>
                                <input class="to w-100 bg-white" type="text" placeholder="ĐẾN" value="${to}">
                            </div>
                            <span class="label-invalid">Vui lòng điền khoảng giá phù hợp</span>
                            <button class="btn-apply py-2 text-white w-100">Áp dụng</button>
                        </div>
                        <ul class="check-box-list mt-3">
                            <li class="mb-1">
                                <label for="i1">
                                    <input id="i1" type="checkbox" value="200000-500000"
                                           <c:if test="${param['minPrice'] == 200000 && param['maxPrice'] == 500000}">checked</c:if>/>200,000đ
                                    - 500,000đ<span class="count">(${requestScope['r1']})</span>
                                </label>
                            </li>
                            <li class="mb-1">
                                <label for="i2">
                                    <input id="i2" type="checkbox" value="500000-1000000"
                                           <c:if test="${param['minPrice'] == 500000 && param['maxPrice'] == 1000000}">checked</c:if>/>500,000đ
                                    - 1,000,000đ<span class="count">(${requestScope['r2']})</span>
                                </label>
                            </li>
                            <li>
                                <label for="i3">
                                    <input id="i3" type="checkbox" value="1000000-2500000"
                                           <c:if test="${param['minPrice'] == 1000000 && param['maxPrice'] == 2500000}">checked</c:if>/>1,000,000đ
                                    - 2,500,000đ<span class="count">(${requestScope['r3']})</span>
                                </label>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-9 col-md-8 col-12">
                <c:if test="${param.search != null}">
                    <div class="search-result mb-4"><i class="bi bi-search"></i> Kết quả tìm kiếm cho từ khóa '<span
                            class="key-word">${param.search}</span>'
                    </div>
                </c:if>
                <!-- Shop Top -->
                <div class="mb-3 pl-2 w-100" style="margin-left: -15px;">
                    <div class="shop-top w-100">
                        <div class="single-shorter">
                            <label class="float-left" for="sl">Sắp xếp theo</label>
                            <select id="sl">
                                <option
                                        <c:if test="${param['sortBy'] == 'name'}">selected</c:if> value="name">Tên
                                </option>
                                <option
                                        <c:if test="${param['sortBy'] == 'price_up'}">selected</c:if> value="price_up">Giá: Thấp đến Cao
                                </option>
                                <option
                                        <c:if test="${param['sortBy'] == 'price_down'}">selected</c:if> value="price_down">Giá: Cao đến Thấp
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row" id="products-container">
                    <c:forEach var="p" items="${requestScope.products}">
                        <div class="col-lg-4 col-md-6 col-12 m-0 p-0">
                            <div class="single-product mt-2 mb-2 mr-2 ml-2" data-quantity="${p.quantity}">
                                <div class="product-img">
                                    <a href="${context}/shop/product-details?product_id=${p.idProduct}">
                                        <img class="default-img" src="${context}/${p.imgPath}" alt="#"/>
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
                                    <c:if test="${p.status != 'Cấm bán'}">
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
                                <c:if test="${p.status == 'Cấm bán'}">
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

                <!-- Pagination -->
                <div class="pagination d-flex justify-content-center mt-4">
                    <div class="pagination-container">
                        <a class="control mr-3" id="control-prev"><i class="bi-chevron-left"></i></a>
                        <a class="control ml-3" id="control-next"><i class="bi-chevron-right"></i></a>
                    </div>
                </div>

                <!-- No Data -->
                <div class="no-data hidden text-center">
                    <img src="${context}/shop/images/no_data.png" alt="No data"> o
                    <c:choose>
                        <%--suppress ELSpecValidationInJSP--%>
                        <c:when test="${param.search != null && param.size() == 1}">
                            <p class="empty-search">Không tìm thấy kết quả</p>
                            <p>Chúng tôi không thể tìm thấy bất kỳ kết quả phù hợp cho cụm từ tìm kiếm của bạn.</p>
                        </c:when>
                        <c:otherwise>
                            <p>Oops! Không có sản phẩm nào. Điều chỉnh bộ lọc và thử lại nhé?</p>
                            <button class="clear-filter">Xóa bộ lọc</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== FOOTER ===== -->
<jsp:include page="../common/shop-footer.jsp"/>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/shop-js.jsp"/>

<script>
    const queryMap = new Map()
    window.location.search.substring(1).split('&').forEach((value) => {
        const item = value.split('=')
        queryMap.set(item[0], item[1])
    })

    $('#sl').on('change', function () {
        const value = $(this).find(':selected').val()
        queryMap.set('sortBy', value)
        query()
    })

    $('.label-input input').on('input', function () {
        $(this).val($(this).val().replace(/[^0-9]/g, '').replace(/(\..*?)\..*/g, '$1'))
        const v1 = Number($('.label-input input:first-child').val()), v2 = Number($('.label-input input:last-child').val())
        if (v1 && v2 && v1 <= v2) $('.label-invalid').css('display', 'none');
    })

    $('.label-input > button').on('click', function () {
        const minPrice = $('.from').val(), maxPrice = $('.to').val();
        if (Number(minPrice) > Number(maxPrice)) {
            $('.label-invalid').css('display', 'inline-block')
        } else {
            queryMap.set('minPrice', minPrice)
            queryMap.set('maxPrice', maxPrice)
            query()
        }
    })

    $('.check-box-list input').on('change', function () {
        $('.check-box-list input').not(this).prop('checked', false)
        if (this.checked) {
            const minPrice = $(this).val().split('-')[0]
            const maxPrice = $(this).val().split('-')[1]
            queryMap.set('minPrice', minPrice)
            queryMap.set('maxPrice', maxPrice)
        } else {
            queryMap.delete('minPrice')
            queryMap.delete('maxPrice')
        }
        query()
    })

    $('.category-list a').on('click', function () {
        const type = queryMap.get($(this).attr('data-select'));
        if (type && type === $(this).attr('data-query'))
            queryMap.delete($(this).attr('data-select'))
        else
            queryMap.set($(this).attr('data-select'), $(this).attr('data-query'))
        query()
        return false;
    })

    function query(isPage) {
        if (queryMap.size === 0) {
            window.location.href = '${context}/shop/products'
            return
        }

        let query = '${context}/shop/products?'

        const search = queryMap.get('search')
        if (search) query = query.concat('&search=').concat(search)

        const type = queryMap.get('type')
        if (type) query = query.concat('&type=').concat(type)

        const subtype = queryMap.get('subtype')
        if (subtype) query = query.concat('&subtype=').concat(subtype)

        const supplier = queryMap.get('supplier')
        if (supplier) query = query.concat('&supplier=').concat(supplier)

        const sort = queryMap.get('sortBy')
        if (sort) query = query.concat('&sortBy=').concat(sort)

        const minPrice = queryMap.get('minPrice')
        if (minPrice) query = query.concat('&minPrice=').concat(minPrice)

        const maxPrice = queryMap.get('maxPrice')
        if (maxPrice) query = query.concat('&maxPrice=').concat(maxPrice)

        const page = queryMap.get('page')
        if (page && isPage) query = query.concat('&page=').concat(page)

        window.location.href = query.replace('?&', '?')
    }

    /**
     * Pagination
     */
    let currentPage = queryMap.get('page') ? Number(queryMap.get('page')) : 1

    $(function () {
        const itemCount = $('#products-container > div').length
        if (itemCount === 0) {
            $('.pagination-container').hide()
            $('.no-data').removeClass('hidden')
            $('.no-data .clear-filter').on('click', function () {
                queryMap.forEach((value, key) => {
                    if (key !== "type" && key !== "subtype" && key !== "search")
                        queryMap.delete(key)
                })
                query()
            })
            return
        }

        const pageCount = Math.ceil(itemCount / 9)
        for (let i = 1; i <= pageCount; i++) {
            const page = document.createElement('a')
            $(page).html(i).attr('page', i).insertBefore('#control-next')
        }

        $('#control-prev').on('click', () => {
            if (currentPage === 1) queryPage(pageCount)
            else queryPage(currentPage - 1)
        })
        $('#control-next').on('click', () => {
            if (currentPage === pageCount) queryPage(1)
            else queryPage(currentPage + 1)
        })

        $('.pagination-container a:not(.control)').each((index, value) => {
            const page = Number($(value).attr('page'))
            if (page) $(value).on('click', () => queryPage(page))
        })

        switchPage(currentPage)
    })

    function queryPage(page) {
        queryMap.set('page', page)
        query(true)
    }

    function switchPage(page) {
        $('.pagination-container > a').each((index, value) => {
            $(value).removeClass('active')
            if (page === Number($(value).attr('page'))) $(value).addClass('active')
        })

        const from = (page - 1) * 9, to = from + 9
        $('#products-container > div').each((index, value) => {
            if (index >= from && index < to) $(value).removeClass('hidden')
            else $(value).addClass('hidden')
        })
    }

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