<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pu" uri="https://com.noithat.functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Thống kê</title>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/admin-css.jsp"/>
</head>

<body class="app sidebar-mini rtl">

<%--<jsp:include page="../common/admin-header.jsp"/>--%>

<jsp:include page="../common/admin-sidebar-menu.jsp"/>

<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="#"><b>Báo cáo doanh thu </b></a></li>
        </ul>
        <div id="clock"></div>
    </div>
    <div class="row">
        <div class="col-md-6 col-lg-3">
            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user fa-3x'></i>
                <div class="info">
                    <h4>Tổng khách hàng</h4>
                    <p><b>${requestScope.infos[0]} khách hàng</b></p>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="widget-small info coloured-icon"><i class='icon bx bxs-purchase-tag-alt fa-3x'></i>
                <div class="info">
                    <h4>Tổng sản phẩm</h4>
                    <p><b>${requestScope.infos[1]} sản phẩm</b></p>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="widget-small warning coloured-icon"><i class='icon fa-3x bx bxs-shopping-bag-alt'></i>
                <div class="info">
                    <h4>Tổng đơn hàng</h4>
                    <p><b>${requestScope.infos[2]} đơn hàng</b></p>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="widget-small danger coloured-icon"><i class='icon fa-3x bx bxs-info-circle'></i>
                <div class="info">
                    <h4>Bị cấm</h4>
                    <p><b>${requestScope.infos[3]} sản phẩm</b></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 col-lg-3">
            <div class="widget-small primary coloured-icon"><i class='icon fa-3x bx bxs-chart'></i>
                <div class="info">
                    <h4>Tổng thu nhập</h4>
                    <p><b>${pu:format(requestScope.infos[4])} đ</b></p>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="widget-small info coloured-icon"><i class='icon fa-3x bx bxs-user-badge'></i>
                <div class="info">
                    <h4>Đã bán</h4>
                    <p><b>${requestScope.infos[5]} sản phẩm</b></p>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="widget-small warning coloured-icon"><i class='icon fa-3x bx bxs-tag-x'></i>
                <div class="info">
                    <h4>Hết hàng</h4>
                    <p><b>${requestScope.infos[6]} sản phẩm</b></p>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="widget-small danger coloured-icon"><i class='icon fa-3x bx bxs-receipt'></i>
                <div class="info">
                    <h4>Đơn hàng hủy</h4>
                    <p><b>${requestScope.infos[7]} đơn hàng</b></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">SẢN PHẨM BÁN CHẠY</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="sampleTable0">
                        <thead>
                        <tr>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá tiền</th>
                            <th>Phân loại</th>
                            <th>Đã bán</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach begin="0" end="5" var="p" items="${requestScope.selling}">
                            <tr>
                                <td>${p.idProduct}</td>
                                <td>${p.name}</td>
                                <td>${pu:format(p.newPrice)} đ</td>
                                <td>${p.subtype}</td>
                                <td>${p.sold}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">ĐƠN HÀNG THÁNG <%=LocalDate.now().getMonth().getValue()%>
                    </h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="sampleTable1">
                        <thead>
                        <tr>
                            <th>ID đơn hàng</th>
                            <th>Khách hàng</th>
                            <th>Đơn hàng</th>
                            <th>Số lượng</th>
                            <th>Tổng tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="totalPrice"/>
                        <c:forEach var="b" items="${requestScope.bills}">
                            <c:set var="totalPrice" value="${totalPrice + b.totalPrice}"/>
                            <tr>
                                <td>${b.id}</td>
                                <td>${b.customerName}</td>
                                <td>
                                    <c:forEach var="bp" items="${b.products}" varStatus="i">
                                        <c:out value="${bp.name}"/><c:if test="${!i.last}"><c:out value=", "/></c:if>
                                    </c:forEach>
                                </td>
                                <td>${b.quantity} sản phẩm</td>
                                <td>${pu:format(b.totalPrice)} đ</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <th colspan="4">Tổng cộng:</th>
                            <td>${pu:format(totalPrice)} đ</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">SẢN PHẨM ĐÃ HẾT</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="sampleTable2">
                        <thead>
                        <tr>
                            <th>Mã sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Phân loại</th>
                            <th>Ảnh</th>
                            <th>Tình trạng</th>
                            <th>Giá tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="oosp" items="${requestScope.oos_products}">
                            <tr>
                                <td>${oosp.idProduct}</td>
                                <td>${oosp.name}</td>
                                <td>${oosp.subtype}</td>
                                <td><img src="${oosp.imgPath}" alt="" width="100px"></td>
                                <td><span class="badge bg-danger">Hết hàng</span></td>
                                <td>${pu:format(oosp.newPrice)}đ</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div>
                    <h3 class="tile-title">KHÁCH HÀNG MỚI</h3>
                </div>
                <div class="tile-body">
                    <table class="table table-hover table-bordered" id="sampleTable3">
                        <thead>
                        <tr>
                            <th>Mã khách hàng</th>
                            <th>Họ và tên</th>
                            <th>Địa chỉ</th>
                            <th>Giới tính</th>
                            <th>SĐT</th>
                            <th>Ngày tạo</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="nc" items="${requestScope.new_cus}">
                            <tr>
                                <td>${nc.id}</td>
                                <td>${nc.fullname}</td>
                                <td>${nc.address}</td>
                                <td>${nc.sex}</td>
                                <td>${nc.phone}</td>
                                <td>${nc.timeCreated}</td>
                                <td><span class="badge bg-success">${nc.status}</span></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="tile">
                <h3 class="tile-title">THỐNG KÊ TỔNG SẢN PHẨM THÊM VÀO VÀ BÁN RA</h3>
                <div class="embed-responsive embed-responsive-16by9">
                    <canvas class="embed-responsive-item" id="line-chart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="tile">
                <h3 class="tile-title">THỐNG KÊ TỔNG DOANH SỐ</h3>
                <div class="embed-responsive embed-responsive-16by9">
                    <canvas class="embed-responsive-item" id="bar-chart"></canvas>
                </div>
            </div>
        </div>
    </div>
    <div class="text-right" style="font-size: 12px">
        <p><b>Hệ thống quản lý</b></p>
    </div>
</main>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/admin-js.jsp"/>
<!-- ================================================================================================== -->
<script>
    const saleArr = [], soldArr = [], addedArr = [], labels = []

    <c:forEach begin="0" end="11" varStatus="i">
        labels['${i.index}'] = 'Tháng ${i.count}'
        saleArr['${i.index}'] = '${requestScope.sales[i.index]}'
        soldArr['${i.index}'] =  '${requestScope.solds[i.index]}'
        addedArr['${i.index}'] = '${requestScope.added[i.index]}'
    </c:forEach>

    const data = {
        labels: labels,
        datasets: [
            {
                label: "Dữ liệu đầu tiên",
                fillColor: "rgba(255, 255, 255, 0.158)",
                strokeColor: "black",
                pointColor: "rgb(220, 64, 59)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "green",
                data: soldArr
            },
            {
                label: "Dữ liệu kế tiếp",
                fillColor: "rgba(255, 255, 255, 0.158)",
                strokeColor: "rgb(220, 64, 59)",
                pointColor: "black",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "green",
                data: addedArr
            }]
    };

    const lineChart = new Chart($("#line-chart").get(0).getContext("2d")).Line(data);

    const barChart = new Chart($('#bar-chart').get(0).getContext('2d')).Bar({
        labels: labels,
        datasets: [{
            fillColor: "rgba(255, 255, 255, 0.158)",
            strokeColor: "rgb(220, 64, 59)",
            pointColor: "black",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "green",
            data: saleArr
        }]
    });
</script>

</body>

</html>