<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 9:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="models.Category" %>
<%@ page import="java.util.List" %>

<%
  Book book = (Book) request.getAttribute("book");
  List<Category> categories = (List<Category>) request.getAttribute("categories");
  boolean isEdit = book != null;
%>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách" %></title>
</head>
<body>
<h2><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách" %></h2>
<form method="post" action="books" enctype="multipart/form-data">
  <% if (isEdit) { %>
  <input type="hidden" name="ma_sach" value="<%= book.getBookId() %>">
  <% } %>

  <label>Tên sách:</label>
  <input type="text" name="ten_sach" value="<%= isEdit ? book.getBookName() : "" %>" required><br>

  <label>Tác giả:</label>
  <input type="text" name="tac_gia" value="<%= isEdit ? book.getAuthor() : "" %>" required><br>

  <label>NXB:</label>
  <input type="text" name="nha_xuat_ban" value="<%= isEdit ? book.getPublisher() : "" %>" required><br>

  <label>Giá:</label>
  <input type="number" name="gia" step="0.01" value="<%= isEdit ? book.getPrice() : "" %>" required><br>

  <label>Mô tả:</label>
  <textarea name="mo_ta" required><%= isEdit ? book.getDescription() : "" %></textarea><br>

  <label>Danh mục:</label>
  <select name="ma_danh_muc" required>
    <option value="">-- Chọn danh mục --</option>
    <% for (Category c : categories) { %>
    <option value="<%= c.getCategoryId() %>"
            <%= isEdit && c.getCategoryId() == book.getCategoryId() ? "selected" : "" %>>
      <%= c.getCategoryName() %>
    </option>
    <% } %>
  </select><br>

  <label>Ảnh sách:</label>
  <% if (isEdit && book.getImgUrl() != null && !book.getImgUrl().isEmpty()) { %>
  <img src="<%= book.getImgUrl() %>" alt="Ảnh sách" width="150"><br>
  <% } %>
  <input type="file" name="img_url" accept="image/*"><br>

  <button type="submit">Lưu</button>
</form>


<a href="books">⬅ Quay lại danh sách</a>
</body>
</html>
