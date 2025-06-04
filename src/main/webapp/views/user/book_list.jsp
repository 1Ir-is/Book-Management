
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="models.Category" %>
<%@ page import="java.util.List" %>


<%
    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">

    <h2 class="mb-4 text-center">Danh sách Sách</h2>

    <!-- Form tìm kiếm -->


    <!-- Hiển thị sách -->
    <div class="row">
        <% if (books != null && !books.isEmpty()) { %>
        <% for (Book book : books) { %>
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <a href="book-detail?id=<%= book.getBookId() %>" style="text-decoration: none; color: inherit;">
                    <% if (book.getImgUrl() != null) { %>
                    <img src="<%= book.getImgUrl() %>" class="card-img-top" alt="Ảnh sách" style="height: 250px; object-fit: contain;">
                    <% } %>
                    <div class="card-body">
                        <h5 class="card-title"><%= book.getBookName() %></h5>
                        <p class="card-text text-danger fw-bold">Giá: <%= book.getPrice() %> VNĐ</p>
                    </div>
                </a>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <p class="text-center">Không tìm thấy sách phù hợp.</p>
        <% } %>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

