
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<%@ page import="model.Admin" %>
<%@ page import="utils.CommonString" %>

<% Admin admin = (Admin) session.getAttribute(CommonString.ADMIN_SESSION);%>
<!-- Sidebar Menu -->
<div class="app-sidebar-overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
  <div class="app-sidebar-user"><img class="admin-avatar" src="https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1" alt="User Image">
    <p class="app-sidebar-user-name"><b>Admin root</b></p>
    <p class="app-sidebar-user-designation"><%=admin.getFullname()%></p>
  </div>
  <hr>
  <ul class="app-menu">
    <li>
      <a class="app-menu-item haha" href="${context}/admin/root-trang-chu"><i class='bx bx-tachometer'></i>
        <span class="app-menu-label">Trang chủ</span></a>
    </li>
    <li>
      <a class="app-menu-item" href="${context}/admin/root-quan-ly-admin"><i class='bx bx-id-card'></i>
        <span class="app-menu-label">Quản lý admin</span></a>
    </li>
    <li>
      <a class="app-menu-item" href="${context}/admin/root-quan-ly-khach-hang"><i class='bx bx-id-card'></i>
        <span class="app-menu-label">Quản lý khách hàng</span></a>
    </li>
    <li>
      <a class="app-menu-item" href="${context}/admin/root-doi-mat-khau"><i class='bx bx-cog'></i>
        <span class="app-menu-label">Đổi mật khẩu</span></a>
    </li>
  </ul>
</aside>
