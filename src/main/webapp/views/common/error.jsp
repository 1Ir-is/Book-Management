<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Lỗi hệ thống</title>
</head>
<body>
<h2>💥 Đã xảy ra lỗi trong hệ thống</h2>
<p>Xin lỗi! Đã có lỗi xảy ra trong quá trình xử lý yêu cầu của bạn.</p>

<%
  if (exception != null) {
%>
<h4>Chi tiết lỗi:</h4>
<pre><%= exception.getMessage() %></pre>
<%
  }
%>

<a href="<%= request.getContextPath() %>/">Quay về trang chủ</a>
</body>
</html>