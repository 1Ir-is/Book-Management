<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    // Hàm tiện lợi: nếu currentPath (vd. "/admin/dashboard") bắt đầu bằng path (vd. "/admin/dashboard") thì trả về "active"
    public String isActive(String path, String currentPath) {
        return currentPath.startsWith(path) ? "active" : "";
    }
%>

<section id="sidebar">
    <%
        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();           // Ví dụ "/YourAppName/admin/dashboard"
        String path = uri.substring(contextPath.length());
        // Sau khi tách contextPath, path = "/admin/dashboard" (hoặc "/admin/dashboard/" nếu có dấu slash cuối)
    %>

    <a href="<%= contextPath %>/admin/dashboard" class="brand">
        <i class="bx bxs-smile icon"></i> Admin
    </a>

    <ul class="side-menu">
        <!-- Dashboard -->
        <li>
            <a href="<%= contextPath %>/admin/dashboard"
               class="<%= isActive("/admin/dashboard", path) %>">
                <i class="bx bxs-dashboard icon"></i> Dashboard
            </a>
        </li>

        <li class="divider" data-text="Management">Management</li>

        <!-- Quản lý sách -->
        <li>
            <a href="<%= contextPath %>/admin/books"
               class="<%= isActive("/admin/books", path) %>">
                <i class="bx bxs-book icon"></i> Quản lý sách
            </a>
        </li>

        <!-- Quản lý thể loại -->
        <li>
            <a href="<%= contextPath %>/admin/categories"
               class="<%= isActive("/admin/categories", path) %>">
                <i class="bx bxs-category icon"></i> Quản lý thể loại
            </a>
        </li>

        <!-- Quản lý người dùng -->
        <li>
            <a href="<%= contextPath %>/admin/users"
               class="<%= isActive("/admin/users", path) %>">
                <i class="bx bxs-user icon"></i> Quản lý người dùng
            </a>
        </li>

        <!-- Quản lý đơn hàng -->
        <li>
            <a href="<%= contextPath %>/admin/orders"
               class="<%= isActive("/admin/orders", path) %>">
                <i class="bx bxs-cart icon"></i> Quản lý đơn hàng
            </a>
        </li>
    </ul>
</section>
