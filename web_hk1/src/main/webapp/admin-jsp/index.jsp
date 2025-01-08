<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Trang chủ</title>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/admin-css.jsp"/>
</head>

<body class="app sidebar-mini rtl">
<%--    Header--%>
<%--<jsp:include page="../common/admin-header.jsp"/>--%>

<!-- Sidebar Menu -->
<jsp:include page="../common/admin-sidebar-menu.jsp"/>

<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb">
            <li class="breadcrumb-item"><a href="#"><b>Trang chủ</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>
    <div class="row">
        <!--Left-->
        <div class="col-md-12 col-lg-6">
            <div class="row">
                <div class="col-md-6">
                    <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                        <div class="info">
                            <h4>Tổng khách hàng</h4>
                            <p><b>${requestScope.stats[0]} khách hàng</b></p>
                            <p class="info-tong">Tổng số khách hàng được quản lý.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="widget-small info coloured-icon"><i class='icon bx bxs-data fa-3x'></i>
                        <div class="info">
                            <h4>Tổng sản phẩm</h4>
                            <p><b>${requestScope.stats[1]} sản phẩm</b></p>
                            <p class="info-tong">Tổng số sản phẩm được quản lý.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                        <div class="info">
                            <h4>Tổng đơn hàng</h4>
                            <p><b>${requestScope.stats[2]} đơn hàng</b></p>
                            <p class="info-tong">Tổng số hóa đơn bán hàng trong tháng.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="widget-small danger coloured-icon"><i class='icon bx bxs-error-alt fa-3x'></i>
                        <div class="info">
                            <h4>Sắp hết hàng</h4>
                            <p><b>${requestScope.stats[3]} sản phẩm</b></p>
                            <p class="info-tong">Số sản phẩm cảnh báo hết cần nhập thêm.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Tình trạng đơn hàng</h3>
                        <div>
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>ID đơn hàng</th>
                                    <th>Tên khách hàng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="bill" items="${requestScope.recent_bills}">
                                    <c:choose>
                                        <c:when test="${bill.status == 'Đang vận chuyển'}"><c:set var="badge" value="bg-warning"/></c:when>
                                        <c:when test="${bill.status == 'Đã giao'}"><c:set var="badge" value="bg-success"/></c:when>
                                        <c:when test="${bill.status == 'Đã hủy'}"><c:set var="badge" value="bg-danger"/></c:when>
                                        <c:when test="${bill.status == 'Chờ xử lý'}"><c:set var="badge" value="bg-info"/></c:when>
                                    </c:choose>
                                    <tr>
                                        <td>${bill.id}</td>
                                        <td>${bill.customerName}</td>
                                        <td>${bill.totalPrice}đ</td>
                                        <td><span class="badge ${badge}">${bill.status}</span></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Khách hàng mới</h3>
                        <div>
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên khách hàng</th>
                                    <th>Email</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="cus" items="${requestScope.recent_customers}">
                                    <c:choose>
                                        <c:when test="${cus.status == 'Bình thường'}"><c:set var="badge" value="bg-success"/></c:when>
                                        <c:when test="${cus.status == 'Tạm khóa'}"><c:set var="badge" value="bg-warning"/></c:when>
                                        <c:when test="${cus.status == 'Khóa vĩnh viễn'}"><c:set var="badge" value="bg-danger"/></c:when>
                                    </c:choose>
                                    <tr>
                                        <td>${cus.id}</td>
                                        <td>${cus.fullname}</td>
                                        <td>${cus.email}</td>
                                        <td><span class="badge ${badge}">${cus.status}</span></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right -->
        <div class="col-md-12 col-lg-6">
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thống kê đơn hàng và khách hàng đăng ký mới</h3>
                        <div class="embed-responsive embed-responsive-16by9">
                            <canvas class="embed-responsive-item" id="line-chart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thống kê doanh thu năm 2023</h3>
                        <div class="embed-responsive embed-responsive-16by9">
                            <canvas class="embed-responsive-item" id="bar-chart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="text-center">
        <p><b>Copyright
            <script>document.write(new Date().getFullYear())</script>
            Phần mềm quản lý bán hàng</b></p>
    </div>
</main>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/admin-js.jsp"/>
<!-- ================================================================================================== -->
<script>
    // Initialize Chart
    const cusArr = [], billArr = [], saleArr = [], labels = []

    <c:forEach begin="0" end="11" varStatus="i">
        labels['${i.index}'] = 'Tháng ${i.count}'
        cusArr['${i.index}'] = '${requestScope.created_customers[i.index]}'
        billArr['${i.index}'] = '${requestScope.ordered_bills[i.index]}'
        saleArr['${i.index}'] = '${requestScope.revenue[i.index]}'
    </c:forEach>

    const lineChart = new Chart($('#line-chart').get(0).getContext('2d')).Line({
        labels: labels,
        datasets: [
            {
                label: "Khách hàng mới",
                fillColor: "rgba(255, 213, 59, 0.767)", strokeColor: "rgb(255, 212, 59)", pointColor: "rgb(255, 212, 59)",
                pointStrokeColor: "rgb(255, 212, 59)", pointHighlightFill: "rgb(255, 212, 59)", pointHighlightStroke: "rgb(255, 212, 59)",
                data: cusArr
            },
            {
                label: 'Đơn hàng mới',
                fillColor: 'rgba(9, 109, 239, 0.651)', pointColor: 'rgb(9, 109, 239)', strokeColor: 'rgb(9, 109, 239)',
                pointStrokeColor: "rgb(9, 109, 239)", pointHighlightFill: 'rgb(9, 109, 239)', pointHighlightStroke: 'rgb(9, 109, 239)',
                data: billArr
            }]
    });

    const barChart = new Chart($('#bar-chart').get(0).getContext('2d')).Bar({
        labels: labels,
        datasets: [{
            fillColor: 'rgba(255, 213, 59, 0.767)', strokeColor: 'rgb(255, 212, 59)', pointColor: 'rgb(255, 212, 59)',
            pointStrokeColor: 'rgb(255, 212, 59)', pointHighlightFill: 'rgb(255, 212, 59)', pointHighlightStroke: 'rgb(255, 212, 59)',
            data: saleArr
        }]
    });
</script>
</body>

</html>