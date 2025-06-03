<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %>
<%
  List<CartDetails> cartItems = (List<CartDetails>) request.getAttribute("cartItems");
%>
<html>
<head>
  <title>Giỏ Hàng</title>
</head>
<body>
<h2>Giỏ hàng của bạn</h2>

<% if (cartItems != null && !cartItems.isEmpty()) { %>
<table border="1" cellpadding="10">
  <tr>
    <th>Ảnh</th>
    <th>Tên sách</th>
    <th>Giá</th>
    <th>Số lượng</th>
    <th>Tổng</th>
  </tr>
  <% double total = 0; %>
  <% for (CartDetails item : cartItems) {
    double itemTotal = item.getQuantity() * item.getBook().getPrice();
    total += itemTotal;
  %>
  <tr>
    <td><img src="<%= item.getBook().getImgUrl() %>" width="50"/></td>
    <td><%= item.getBook().getBookName() %></td>
    <td><%= item.getBook().getPrice() %> VNĐ</td>
    <td><%= item.getQuantity() %></td>
    <td><%= itemTotal %> VNĐ</td>
  </tr>
  <% } %>
  <tr>
    <td colspan="4" align="right"><strong>Tổng cộng:</strong></td>
    <td><strong><%= total %> VNĐ</strong></td>
  </tr>
</table>
<% } else { %>
<p>Giỏ hàng của bạn đang trống.</p>
<% } %>

<a href="books">← Tiếp tục mua sắm</a>
</body>
</html>
