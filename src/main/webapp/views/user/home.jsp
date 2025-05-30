<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:36 AM
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
  <title>Home</title>
</head>
<body>
<h2>Trang chủ</h2>

<%
  if (user != null) {
%>
<p>Chào mừng, <%= user.getName() %>!</p>
<a href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
<%
} else {
%>
<p>Bạn chưa đăng nhập.</p>
<a href="<%= request.getContextPath() %>/login">Đăng nhập</a> |
<a href="<%= request.getContextPath() %>/register">Đăng ký</a>
<%
  }
%>

</body>
</html>
