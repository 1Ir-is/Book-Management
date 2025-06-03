<%@ page import="models.OrderDetails" %>
<%@ page import="java.util.Map" %>
<%@ page import="models.Book" %><%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 03/06/2025
  Time: 11:48 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Thông tin giỏ hàng:</h2>
<table border="1">
    <tr>
        <th>ID SP</th>
        <th>Tên SP</th>
        <th>Ảnh</th>
        <th>Số lượng</th>
        <th>Giá</th>
        <th>Tổng tiền</th>
        <th>Lựa chọn</th>
    </tr>

    <%
        Object cartObject = session.getAttribute("cart");
        if (cartObject != null) {
            Map<Integer, OrderDetails> cart = (Map<Integer, OrderDetails>) cartObject;
            for (Map.Entry<Integer, OrderDetails> entry : cart.entrySet()) {
                int id = entry.getKey();
                OrderDetails item = entry.getValue();
                Book book = item.getBook();
    %>
    <tr>
        <td><%= id %>
        </td>
        <td><%= book.getBookName() %>
        </td>
        <td>
            <img src="<%= request.getContextPath() %>/download?image=<%= book.getImgUrl() %>" width="100"/>
        </td>
        <td><%= item.getQuantity() %>
        </td>
        <td><%= item.getPrice() %>
        </td>
        <td><%= item.getPrice() * item.getQuantity() %>
        </td>
        <td>
            <a href="<%= request.getContextPath() %>/delete-from-cart?key=<%= id %>">Xóa</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="7">Giỏ hàng trống.</td>
    </tr>
    <%
        }
    %>
</table>

<a href="<%= request.getContextPath() %>/member/add-order">Thanh toán</a>
</body>
</html>
