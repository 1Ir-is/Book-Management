<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="models.User" %>
<%@ page import="models.Category" %>
<%@ page import="java.util.List" %>



<%
  User user = (User) session.getAttribute("user");
  List<Category> categories = (List<Category>) request.getAttribute("categories");
  String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
  String categorySelected = request.getParameter("category") != null ? request.getParameter("category") : "";
%>
<html>
<head>
  <meta charset="UTF-8">
  <title>Home</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<h2>Trang chủ</h2>
<%
  if (user != null) {
%>
<p>Chào mừng, <%= user.getName() %>!</p>
<a href="<%= request.getContextPath() %>/logout">Đăng xuất</a>
<a href="<%= request.getContextPath() %>/books">Xem sách</a>
<form method="get" action="books" class="row g-3 mb-4 justify-content-center">
  <div class="col-auto">
    <input type="text" name="keyword" placeholder="Tìm theo tên sách..." class="form-control" value="<%= keyword %>">
  </div>
  <div class="col-auto">
    <select name="category" class="form-select">
      <option value="">-- CHỌN THỂ LOẠI --</option>
      <% if (categories != null) {
        for (Category category : categories) { %>
      <option value="<%= category.getCategoryId() %>" <%= categorySelected.equals(String.valueOf(category.getCategoryId())) ? "selected" : "" %>>
        <%= category.getCategoryName() %>
      </option>
      <%   }
      } else { %>
      <option disabled>Không có thể loại</option>
      <% } %>
    </select>

  </div>
  <div class="col-auto">
    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
  </div>
</form>

<%
} else {
%>
<p>Bạn chưa đăng nhập.</p>
<a href="<%= request.getContextPath() %>/login">Đăng nhập</a> |
<a href="<%= request.getContextPath() %>/register">Đăng ký</a>
<a href="<%= request.getContextPath() %>/books">Xem sách</a>
<form method="get" action="books" class="row g-3 mb-4 justify-content-center">
  <div class="col-auto">
    <input type="text" name="keyword" placeholder="Tìm theo tên sách..." class="form-control" value="<%= keyword %>">
  </div>
  <div class="col-auto">
    <select name="category" class="form-select">
      <option value="">-- Chọn thể loại --</option>
      <% if (categories != null) {
        for (Category category : categories) { %>
      <option value="<%= category.getCategoryId() %>" <%= categorySelected.equals(String.valueOf(category.getCategoryId())) ? "selected" : "" %>>
        <%= category.getCategoryName() %>
      </option>
      <%   }
      } else { %>
      <option disabled>Không có thể loại</option>
      <% } %>
    </select>

  </div>
  <div class="col-auto">
    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
  </div>
</form>
<%
  }
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
