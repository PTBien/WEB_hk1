
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>

<header class="app-header">
    <a class="app-sidebar-toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
    <ul class="app-nav">
        <li>
            <a class="app-nav-item" href="${context}/admin/dang-xuat"><i class='bx bx-log-out bx-rotate-180'></i></a>
        </li>
    </ul>
</header>