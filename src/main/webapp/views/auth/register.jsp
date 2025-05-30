<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register</title>
</head>
<body>
<h2>Đăng ký</h2>
<form method="post" action="<%= request.getContextPath() %>/register">
  Tên: <input type="text" name="ten" required><br><br>
  Email: <input type="email" name="email" required><br><br>
  Mật khẩu: <input type="password" name="mat_khau" required><br><br>
  Số điện thoại: <input type="text" name="so_dien_thoai"><br><br>
  Địa chỉ: <input type="text" name="dia_chi"><br><br>
  <button type="submit">Đăng ký</button>
</form>

<%
  String error = (String) request.getAttribute("error");
  if (error != null) {
%>
<p style="color:red"><%= error %></p>
<%
  }
%>

<p>Đã có tài khoản? <a href="<%= request.getContextPath() %>/login">Đăng nhập ngay</a></p>
</body>
</html>
