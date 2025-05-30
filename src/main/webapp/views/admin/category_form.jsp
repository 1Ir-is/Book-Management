<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 9:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Category" %>
<%
    Category category = (Category) request.getAttribute("category");
    boolean isEdit = category != null;
%>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Chỉnh sửa Danh mục" : "Thêm Danh mục" %></title>
</head>
<body>
<h2><%= isEdit ? "Chỉnh sửa Danh mục" : "Thêm Danh mục" %></h2>
<form method="post" action="categories">
    <% if (isEdit) { %>
    <input type="hidden" name="ma_danh_muc" value="<%= category.getCategoryId() %>">
    <% } %>
    <label>Tên danh mục:</label>
    <input type="text" name="ten_danh_muc" value="<%= isEdit ? category.getCategoryName() : "" %>" required><br>
    <button type="submit"><%= isEdit ? "Cập nhật" : "Thêm mới" %></button>
</form>
<a href="categories">⬅ Quay lại danh sách</a>
</body>
</html>