<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 6/9/2025
  Time: 8:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Lịch sử đơn hàng</h2>

<c:if test="${empty orders}">
  <p>Bạn chưa có đơn hàng nào.</p>
</c:if>

<c:if test="${not empty orders}">
  <table>
    <tr>
      <th>Mã đơn</th>
      <th>Ngày đặt</th>
      <th>Trạng thái</th>
    </tr>
    <c:forEach var="order" items="${orders}">
      <tr>
        <td>${order.orderId}</td>
        <td>${order.orderDate}</td>
        <td>${order.status}</td>
      </tr>
    </c:forEach>
  </table>
</c:if>

</body>
</html>
