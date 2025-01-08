<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Quản lý admin</title>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/admin-css.jsp"></jsp:include>
</head>

<body class="app sidebar-mini rtl">

<jsp:include page="../common/admin-header.jsp"/>
<jsp:include page="../common/admin-root-sidebar-menu.jsp"/>

<main class="app-content">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Quản lý admin</b></a></li>
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
                            <!-- <span class="status">Hiện <span class="quantity">10</span> tài khoản</span> -->
                        </div>
                        <div class="search-wrap">
                            <label class="font-weight-bold m-0" for="search">Tìm kiếm : </label>
                            <input type="text" placeholder="" id="search">
                            <label for="by" class="font-weight-bold m-0 ml-3">Theo: </label>
                            <select id="by">
                                <option>Tài khoản</option>
                                <option>Quyền</option>
                            </select>
                        </div>
                    </div>
                    <!-- Table -->
                    <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0"
                           id="sampleTable">
                        <thead>
                        <tr>
                            <th>Tài khoản</th>
                            <th>Quyền</th>
                            <th>Sửa</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>tranmvanphuquy@gmail.com</td>
                            <td>Quản lí admin</td>
                            <td>
                                <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" id="show-emp"
                                        data-toggle="modal" data-target="#modal-up"><i
                                        class="fas fa-edit"></i></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>

<div class="modal fade" id="modal-up" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
     data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="form-group  col-md-12">
                            <span class="thong-tin-thanh-toan">
                                <h5>Chỉnh sửa thông tin tài khoản của admin</h5>
                            </span>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label class="control-label">Mật khẩu</label>
                    <input class="form-control" type="text" placeholder="it_nlu_2022">
                </div>
                <div class="form-group col-md-6">
                    <label for="exampleSelect1" class="control-label">Quyền</label>
                    <select class="form-control" id="exampleSelect1">
                        <option>Root - Admin</option>
                        <option>Normal - Admin</option>
                    </select>
                </div>
                <div class="form-group col-md-6">
                    <label for="exampleSelect1" class="control-label">Trạng thái tài khoản</label>
                    <select class="form-control" id="exampleSelect2">
                        <option>Tạm khóa</option>
                        <option>Bình thường</option>
                    </select>
                </div>
            </div>
            <div class="d-flex justify-content-end mt-3">
                <button class="btn btn-save mr-3">Lưu lại</button>
                <button class="btn btn-cancel" data-dismiss="modal">Hủy bỏ</button>
            </div>
        </div>
        <div class="modal-footer"></div>
    </div>
</div>
</div>

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