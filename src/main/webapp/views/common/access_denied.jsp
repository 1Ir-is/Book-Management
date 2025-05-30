<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Truy cập bị từ chối</title>
</head>
<body>
<h2>Truy cập bị từ chối</h2>
<p>Bạn không có quyền truy cập vào trang này.</p>
<a href="<%= request.getContextPath() %>/">Quay về trang chủ</a>
</body>
</html>
