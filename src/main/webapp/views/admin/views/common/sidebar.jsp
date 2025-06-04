<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String contextPath = request.getContextPath();
    String uri = request.getRequestURI();
    String path = uri.substring(contextPath.length());

    if (path.endsWith("/")) {
        path = path.substring(0, path.length() - 1);
    }
%>

<%= "ContextPath: " + contextPath + "<br>" %>
<%= "URI: " + uri + "<br>" %>
<%= "Path: " + path + "<br>" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
            href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/adminpage.css" />
    <title>Admin Dashboard</title>
</head>
<body>
<section id="sidebar">
    <a href="<%= contextPath %>/admin/dashboard" class="brand">
        <i class="bx bxs-smile icon"></i> Admin
    </a>

    <ul class="side-menu">
        <li>
            <a href="<%= contextPath %>/admin/dashboard"
                    <%= path.contains("dashboard.jsp") ? "class='active'" : "" %>>
                <i class="bx bxs-dashboard icon"></i> Dashboard
            </a>
        </li>

        <li class="divider" data-text="Management">Management</li>

        <li>
            <a href="<%= contextPath %>/admin/books"
                    <%= path.contains("book_list.jsp") ? "class='active'" : "" %>>
                <i class="bx bxs-book icon"></i> Quản lý sách
            </a>
        </li>


        <li>
            <a href="<%= contextPath %>/admin/categories"
                    <%= path.contains("category_list.jsp") ? "class='active'" : "" %>>
                <i class="bx bxs-category icon"></i> Quản lý thể loại
            </a>
        </li>

        <li>
            <a href="<%= contextPath %>/admin/users"
                    <%= path.startsWith("/admin/users") ? "class='active'" : "" %>>
                <i class="bx bxs-user icon"></i> Quản lý người dùng
            </a>
        </li>

        <li>
            <a href="<%= contextPath %>/admin/orders"
                    <%= path.startsWith("/admin/orders") ? "class='active'" : "" %>>
                <i class="bx bxs-cart icon"></i> Quản lý đơn hàng
            </a>
        </li>
    </ul>
</section>


<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="<%= request.getContextPath() %>/assets/js/script.js"></script>

</body>
</html>
