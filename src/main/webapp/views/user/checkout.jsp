<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Xác nhận đặt hàng</title>
</head>
<body>
<h2>Xác nhận đặt hàng</h2>

<c:if test="${not empty cartItems}">
    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
        <tr>
            <th>Tên sách</th>
            <th>Số lượng</th>
            <th>Đơn giá</th>
            <th>Thành tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="tongTien" value="0" />
        <c:forEach var="item" items="${cartItems}">
            <tr>
                <td>${item.book.bookName}</td>
                <td>${item.quantity}</td>
                <td>${item.book.price} VNĐ</td>
                <td>
                    <c:set var="thanhTien" value="${item.book.price * item.quantity}" />
                        ${thanhTien} VNĐ
                    <c:set var="tongTien" value="${tongTien + thanhTien}" />
                </td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="3"><strong>Tổng cộng:</strong></td>
            <td><strong>${tongTien} VNĐ</strong></td>
        </tr>
        </tfoot>
    </table>

    <form action="${pageContext.request.contextPath}/cart" method="post">
        <input type="hidden" name="action" value="batch">
        <input type="hidden" name="subAction" value="checkout">
        <c:forEach var="item" items="${cartItems}">
            <input type="hidden" name="selectedBooks" value="${item.book.bookId}">
        </c:forEach>
        <button type="submit">Xác nhận đặt hàng</button>
    </form>
</c:if>

<c:if test="${empty cartItems}">
    <p>Không có sản phẩm nào trong giỏ hàng.</p>
</c:if>

<a href="${pageContext.request.contextPath}/cart">← Quay lại giỏ hàng</a>
</body>
</html>
