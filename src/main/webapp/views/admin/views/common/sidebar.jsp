<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section id="sidebar">
    <a href="#" class="brand"><i class="bx bxs-smile icon"></i> Admin</a>
    <ul class="side-menu">
        <li>
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="active"
            ><i class="bx bxs-dashboard icon"></i> Dashboard</a
            >
        </li>
        <li class="divider" data-text="Management">Management</li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/books"
            ><i class="bx bxs-book icon"></i> Quản lý sách</a
            >
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/categories"
            ><i class="bx bxs-category icon"></i> Quản lý thể loại</a
            >
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/users"
            ><i class="bx bxs-user icon"></i> Quản lý người dùng</a
            >
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/orders"
            ><i class="bx bxs-cart icon"></i> Quản lý đơn hàng</a
            >
        </li>
    </ul>
</section>