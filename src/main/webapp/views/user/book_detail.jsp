<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    Book book = (Book) request.getAttribute("book");
    Map<Integer, String> categoryMap = (Map<Integer, String>) request.getAttribute("categoryMap");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sách</title>
</head>
<body>
<h2>Chi Tiết Sách</h2>

<% if (book != null) { %>
<% if (book.getImgUrl() != null) { %>
<img src="<%= book.getImgUrl() %>" alt="Ảnh sách" width="150">
<form action="<%= request.getContextPath() %>/cart" method="post" style="margin-top: 10px;">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
    <label>Số lượng:</label>
    <input type="number" name="soLuong" value="1" min="1" required>
    <button type="submit">Thêm vào giỏ hàng</button>
</form>
<button>Mua ngay</button><br>
<% } %>
<strong>Tên sách:</strong> <%= book.getBookName() %><br>
<strong>Tác giả:</strong> <%= book.getAuthor() %><br>
<strong>Nhà xuất bản:</strong> <%= book.getPublisher() %><br>
<strong>Giá:</strong> <%= book.getPrice() %> VNĐ<br>
<strong>Mô tả:</strong> <%= book.getDescription() %><br>
<strong>Thể loại:</strong> <%= categoryMap.get(book.getCategoryId()) %><br>

<br><a href="books">← Quay lại danh sách</a>
<% } else { %>
<p>Không tìm thấy thông tin sách.</p>
<% } %>
</body>
</html>
