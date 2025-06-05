<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<section id="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="brand">
        <i class="bx bxs-smile icon"></i> Admin
    </a>

    <ul class="side-menu">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="${fn:contains(pageContext.request.requestURI, 'dashboard.jsp') ? 'active' : ''}">
                <i class="bx bxs-dashboard icon"></i> Dashboard
            </a>
        </li>

        <li class="divider" data-text="Management">Management</li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/books"
               class="${fn:contains(pageContext.request.requestURI, 'book_list.jsp') ? 'active' : ''}">
                <i class="bx bxs-book icon"></i> Quản lý sách
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/categories"
               class="${fn:contains(pageContext.request.requestURI, 'category_list.jsp') ? 'active' : ''}">
                <i class="bx bxs-category icon"></i> Quản lý thể loại
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/users"
               class="${fn:startsWith(pageContext.request.requestURI, '/admin/users') ? 'active' : ''}">
                <i class="bx bxs-user icon"></i> Quản lý người dùng
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/admin/orders"
               class="${fn:startsWith(pageContext.request.requestURI, '/admin/orders') ? 'active' : ''}">
                <i class="bx bxs-cart icon"></i> Quản lý đơn hàng
            </a>
        </li>
    </ul>
</section>