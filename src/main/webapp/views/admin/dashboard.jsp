<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
</head>
<body>
<h2>🎯 Trang Quản trị</h2>

<%
    if (user != null && user.getRoleId() == 0) {
%>
<p>Chào mừng quản trị viên: <strong><%= user.getName() %></strong></p>
<ul>
    <li><a href="<%= request.getContextPath() %>/admin/books">Quản lý sách</a></li>
    <li><a href="<%= request.getContextPath() %>/admin/categories">Quản lý danh muc</a></li>
    <li><a href="<%= request.getContextPath() %>/some-admin-action">Quản lý người dùng</a></li>
    <li><a href="<%= request.getContextPath() %>/another-admin-action">Thống kê</a></li>
</ul>

<a href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
<%
} else {
%>
<p>Bạn không có quyền truy cập vào trang này.</p>
<%
    }
%>
</body>
</html>