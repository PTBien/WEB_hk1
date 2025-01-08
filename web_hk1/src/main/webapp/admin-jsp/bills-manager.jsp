<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pu" uri="https://com.noithat.functions" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội thất Future | Quản lý đơn hàng</title>

    <!-- ===== STYLESHEET ===== -->
    <jsp:include page="../common/admin-css.jsp"/>
</head>

<body class="app sidebar-mini rtl">
<%--    Header--%>
<%--<jsp:include page="../common/admin-header.jsp"/>--%>

<!-- Sidebar Menu -->
<jsp:include page="../common/admin-sidebar-menu.jsp"/>

<main class="app-content" id="bill-page">
    <div class="app-title">
        <ul class="app-breadcrumb breadcrumb side">
            <li class="breadcrumb-item active"><a href="#"><b>Quản lý đơn hàng</b></a></li>
        </ul>
        <div id="clock"></div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="tile">
                <div class="tile-body">
                    <div class="row element-button">
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm print-file" type="button" title="In"
                               onclick="myApp.printTable()"><i class="fas fa-print"></i> In dữ liệu</a>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-excel btn-sm" href="" title="In"><i class="fas fa-file-excel"></i> Xuất
                                Excel</a>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-delete btn-sm pdf-file" type="button" title="In"
                               onclick="myApp.printTable()"><i class="fas fa-file-pdf"></i> Xuất PDF</a>
                        </div>
                    </div>
                    <table class="table table-hover table-bordered bill-table" id="sampleTable">
                        <thead>
                        <tr>
                            <th class="text-center">ID đơn hàng</th>
                            <th class="text-center">Khách hàng</th>
                            <th class="text-center">Đơn hàng</th>
                            <th class="text-center">Tổng tiền</th>
                            <th class="text-center">Tình trạng</th>
                            <th class="text-center">Địa chỉ giao hàng</th>
                            <th class="text-center">Ngày đặt hàng</th>
                            <th class="text-center">Chỉnh sửa</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="b" items="${requestScope.bills}">
                            <c:choose>
                                <c:when test="${b.status == 'Đã giao'}"><c:set var="bg" value="bg-success"/></c:when>
                                <c:when test="${b.status == 'Đang vận chuyển'}"><c:set var="bg" value="bg-warning"/></c:when>
                                <c:when test="${b.status == 'Đã hủy'}"><c:set var="bg" value="bg-danger"/></c:when>
                                <c:when test="${b.status == 'Chờ xử lý'}"><c:set var="bg" value="bg-info"/></c:when>
                            </c:choose>
                            <tr>
                                <td data-bbid="${b.id}" class="text-center">#${b.id}</td>
                                <td>${b.customerName}</td>
                                <td>
                                    <c:forEach var="p" items="${b.products}" varStatus="ii">
                                        <c:out value="${p.name}"/>
                                        <c:if test="${!ii.last}"><c:out value=", "/></c:if>
                                    </c:forEach>
                                </td>
                                <td data-price="${b.totalPrice}" class="text-center">${pu:format(b.totalPrice)}đ</td>
                                <td data-ss="${bg}" class="text-center"><span class="badge ${bg}">${b.status}</span></td>
                                <td>${b.address}</td>
                                <td>${b.timeOrder}</td>
                                <td class="text-center">
                                    <button class="btn btn-primary btn-sm edit" type="button" title="Sửa"><i
                                            class="fas fa-edit"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>

<div class="modal fade modal-bill" id="modal-up" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"
     data-keyboard="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content mt-5">
            <div class="modal-body p-4">
                <div class="row">
                    <div class="form-group col-md-12">
                            <span class="thong-tin-thanh-toan">
                                <h5>Chỉnh sửa đơn hàng</h5>
                            </span>
                    </div>
                </div>
                <div class="row">
                    <input type="hidden" id="input-bill-id">
                    <div class="form-group col-md-6">
                        <label class="control-label">Tên khách hàng</label>
                        <input class="form-control" type="text" required name="bill-customer">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Địa chỉ giao hàng</label>
                        <input class="form-control" type="text" required name="bill-address">
                    </div>
                    <div class="form-group col-md-6">
                        <label class="control-label">Tổng thanh toán</label>
                        <input class="form-control" type="number" name="bill-price">
                    </div>
                    <div class="form-group col-md-6 ">
                        <label for="select-status" class="control-label">Tình trạng đơn hàng</label>
                        <select class="form-control" id="select-status" name="bill-status">
                            <option value="bg-info">Chờ xử lý</option>
                            <option value="bg-warning">Đang vận chuyển</option>
                            <option value="bg-success">Đã giao</option>
                            <option value="bg-danger">Đã hủy</option>
                        </select>
                    </div>
                </div>
                <div class="d-flex justify-content-end mt-3">
                    <button class="btn btn-save mr-3" type="submit">Lưu lại</button>
                    <button class="btn btn-cancel" data-dismiss="modal">Hủy bỏ</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ===== JAVASCRIPT ===== -->
<jsp:include page="../common/admin-js.jsp"/>
<!-- ================================================================================================== -->
<script>
    $('.edit').on('click', function () {
        const modal = $('#modal-up')
        modal.find('#input-bill-id').val($(this).closest('tr').find('td:first-child').attr('data-bbid'))
        modal.find('input[name=bill-customer]').val($(this).closest('tr').find('td:nth-child(2)').text())
        modal.find('input[name=bill-address]').val($(this).closest('tr').find('td:nth-child(6)').text())
        modal.find('input[name=bill-price]').val($(this).closest('tr').find('td:nth-child(4)').attr('data-price'))
        const bg = String($(this).closest('tr').find('td:nth-child(5)').attr('data-ss'))
        modal.find('select[name=bill-status] option').each(function () {
            if (String($(this).val()) === bg)
                $(this).attr('selected', 'selected')
        })
        modal.modal('show')
    })

    $('.btn-save').on('click', function () {
        const form = $('<form></form>').attr('method', 'post').attr('action', '${context}/admin/quan-ly-don-hang')
        const fieldId = $('<input>').attr('type', 'hidden').attr('name', 'bill_id')
            .attr('value', $('#input-bill-id').val())
        const fieldCus = $('<input>').attr('type', 'hidden').attr('name', 'bill_cus')
            .attr('value', $('input[name=bill-customer]').val())
        const fieldPrice = $('<input>').attr('type', 'hidden').attr('name', 'bill_price')
            .attr('value', $('input[name=bill-price]').val())
        const fieldStatus = $('<input>').attr('type', 'hidden').attr('name', 'bill_status')
            .attr('value', $('#select-status').find(':selected').val())
        const fieldAddress = $('<input>').attr('type', 'hidden').attr('name', 'bill_address')
            .attr('value', $('input[name=bill-address]').val())
        form.append(fieldId).append(fieldCus).append(fieldPrice).append(fieldStatus).append(fieldAddress)

        $(document.body).append(form)
        form.submit()
    })

    const myApp = new function () {
        this.printTable = function () {
            const tab = document.getElementById('sampleTable');
            const win = window.open('', '', 'height=700,width=700');
            win.document.write(tab.outerHTML);
            win.document.close();
            win.print();
        }
    }

    $('#sampleTable').dataTable({
        // order: false,
        order: [[ 0, 'asc' ]]
    });

    $('.btn-excel').on('click', function () {
        TableToExcel.convert(document.getElementById('sampleTable'), {
            name: `bill_management.xlsx`
        });
        return false
    })

    $('.pdf-file').on('click', function () {
        const pdf = new jsPDF('p', 'pt', 'letter');
        const source = $('#sampleTable');

        const margins = {
            top: 80,
            bottom: 60,
            left: 40,
            width: 522
        };

        pdf.fromHTML(
            source,
            margins.left,
            margins.top, {
                'width': margins.width
            },

            function () {
                pdf.save('Test.pdf');
            }, margins);
    })
</script>
</body>

</html>