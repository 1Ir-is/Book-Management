<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="views/common/header.jsp" />

<style>
    body {
        background-color: #f9f9f9;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    h2 {
        text-align: center;
        margin: 40px 0 20px;
        color: #2c3e50;
        font-size: 28px;
        font-weight: bold;
    }

    table {
        width: 90%;
        margin: 0 auto 50px auto;
        border-collapse: collapse;
        background-color: #fff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    thead {
        background-color: #27ae60;
        color: white;
    }

    th, td {
        padding: 15px;
        text-align: center;
        font-size: 16px;
        border-bottom: 1px solid #ddd;
    }

    tbody tr:hover {
        background-color: #f2f2f2;
    }

    img {
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        width: 60px;
        height: auto;
    }

    .back-link {
        display: block;
        text-align: center;
        margin-bottom: 30px;
        font-size: 16px;
        color: #2980b9;
        text-decoration: none;
        transition: color 0.3s;
    }

    .back-link:hover {
        color: #1abc9c;
    }
</style>

<h2>Chi Tiết Đơn Hàng</h2>

<table>
    <thead>
    <tr>
        <th>Ảnh</th>
        <th>Tên Sách</th>
        <th>Số Lượng</th>
        <th>Giá</th>
        <th>Thành Tiền</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${orderDetails}">
        <tr>
            <td><img src="${item[1]}" alt="${item[0]}"/></td>
            <td>${item[0]}</td>
            <td>${item[2]}</td>
            <td><fmt:formatNumber value="${item[3]}" type="currency" currencySymbol=""/>đ</td>
            <td><fmt:formatNumber value="${item[4]}" type="currency" currencySymbol=""/>đ</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<a class="back-link" href="${pageContext.request.contextPath}/user/cart?action=history">← Quay lại lịch sử</a>

<jsp:include page="views/common/footer.jsp" />
