<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 04/06/2025
  Time: 9:34 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Lịch Sử</title>
</head>
<body>
<h2>Lịch sử đơn hàng</h2>

<c:forEach var="order" items="${orders}">
    <div>
        <h3>Đơn hàng #${order.orderId} - Ngày: ${order.orderDate}</h3>
        <p>Trạng thái: ${order.status}</p>
        <ul>
            <c:forEach var="detail" items="${order.details}">
                <li>${detail.bookTitle} - Số lượng: ${detail.quantity} - Giá: ${detail.price}</li>
            </c:forEach>
        </ul>
        <hr>
    </div>
</c:forEach>
</body>
</html>
