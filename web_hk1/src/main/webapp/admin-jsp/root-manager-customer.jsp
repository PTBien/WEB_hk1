<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Quản lý khách hàng</title>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/admin-css.jsp"></jsp:include>
</head>

<body class="app sidebar-mini rtl">
<%--    Header--%>
<jsp:include page="../common/admin-header.jsp"/>

<!-- Sidebar Menu -->
<jsp:include page="../common/admin-root-sidebar-menu.jsp"/>

<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Quản lý khách hàng</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <!-- Action Buttons -->
                    <div class="row element-button">
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm print-file" type="button" title="In"><i
                                    class="fas fa-print"></i> In dữ liệu</a>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-excel btn-sm" href="" title="In"><i class="fas fa-file-excel"></i> Xuất
                                Excel</a>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"><i
                                    class="fas fa-file-pdf"></i> Xuất PDF</a>
                        </div>
                    </div>
                    <!-- Search -->
                    <div class="search-bar d-flex justify-content-between my-3">
                        <div class="d-flex align-items-center">
                            <span class="status">Hiện <span class="quantity">10</span> danh mục</span>
                        </div>
                        <div class="search-wrap">
                            <label class="font-weight-bold m-0" for="search">Tìm kiếm: </label>
                            <input type="text" placeholder="" id="search">
                            <label for="by" class="font-weight-bold m-0 ml-3">Theo: </label>
                            <select id="by">
                                <option>ID</option>
                                <option>Tên</option>
                            </select>
                        </div>
                    </div>
                    <!-- Table -->
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           id="sampleTable">
                        <thead>
                        <tr>
                            <th>ID khách hàng</th>
                            <th>Họ và tên</th>
                            <th>SĐT</th>
                            <th>Email</th>
                            <th>Địa chỉ</th>
                            <th>Giới tính</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>CD12837</td>
                            <td>Hồ Thị Thanh Ngân</td>
                            <td>0123456789</td>
                            <td>ngan@123gmail.com</td>
                            <td>155-157 Trần Quốc Thảo, Quận 3, Hồ Chí Minh</td>
                            <td>Nữ</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/admin-js.jsp"></jsp:include>
<!-- ================================================================================================== -->
<script>
    // In dữ liệu
    var myApp = new (function () {
        this.printTable = function () {
            var tab = document.getElementById("sampleTable");
            var win = window.open("", "", "height=700,width=700");
            win.document.write(tab.outerHTML);
            win.document.close();
            win.print();
        };
    })();

</script>
</body>

</html>