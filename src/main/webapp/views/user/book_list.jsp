<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="java.util.List" %>

<%
    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sách</title>
    <!-- Bootstrap CSS CDN (v5) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<%--<body>--%>
<%--<h2>Danh sách Các Loại Sách</h2>--%>

<%--<% if (books != null && !books.isEmpty()) { %>--%>
<%--<ul>--%>
<%--    <% for (Book book : books) { %>--%>
<%--    <li>--%>
<%--        <a href="book-detail?id=<%= book.getBookId() %>">--%>
<%--            <% if (book.getImgUrl() != null) { %>--%>
<%--            <img src="<%= book.getImgUrl() %>" alt="Ảnh sách" width="100"><br>--%>
<%--            <strong><%= book.getBookName() %></strong><br>--%>
<%--            &lt;%&ndash;        Tác giả: <%= book.getAuthor() %><br>&ndash;%&gt;--%>
<%--            &lt;%&ndash;        Nhà Xuất Bản: <%= book.getPublisher() %><br>&ndash;%&gt;--%>
<%--            Giá: <%= book.getPrice() %> VNĐ<br>--%>
<%--            &lt;%&ndash;        Mô tả: <%= book.getDescription() %><br>&ndash;%&gt;--%>
<%--            &lt;%&ndash;        Thể loại: <%= categoryMap.get(book.getCategoryId()) %><br>&ndash;%&gt;--%>

<%--        </a>--%>

<%--        <% } %>--%>
<%--        <hr>--%>
<%--    </li>--%>
<%--    <% } %>--%>
<%--</ul>--%>
<%--<% } else { %>--%>
<%--<p>Hiện chưa có sách nào.</p>--%>
<%--<% } %>--%>

<%--</body>--%>
<body>
<div class="container mt-4">
    <h2 class="mb-4 text-center">Danh sách Sách</h2>

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
        <p class="text-center">Hiện chưa có sách nào.</p>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS (nếu cần tương tác như modal, dropdown...) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
