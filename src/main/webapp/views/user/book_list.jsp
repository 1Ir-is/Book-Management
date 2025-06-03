<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<%
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sách | 4Book</title>
    <!-- Icon -->
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/assets/image/book-shop.png" />

    <!-- Font awesome cdn link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- Custom Css file link -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>
<!-- header section start -->
<jsp:include page="views/common/header.jsp" />
<!-- header section end -->

<!-- Book List Section -->
<section class="books-list" style="padding: 5rem 9%">
    <h1 class="heading"><span>Tất cả Sách</span></h1>
    <div class="books-grid">
        <% if (books != null && !books.isEmpty()) { %>
        <% for (Book book : books) { %>
        <div class="book-box">
            <div class="image">
                <a href="<%= request.getContextPath() %>/book-detail?id=<%= book.getBookId() %>">
                    <% if (book.getImgUrl() != null) { %>
                    <img src="<%= book.getImgUrl() %>" alt="Ảnh sách" />
                    <% } %>
                </a>
            </div>
            <div class="content">
                <h3>
                    <a href="<%= request.getContextPath() %>/book-detail?id=<%= book.getBookId() %>" style="color: inherit; text-decoration: none">
                        <%= book.getBookName() %>
                    </a>
                </h3>
                <div class="price"><%= currencyFormat.format(book.getPrice()) %> đ</div>
                <a href="#" class="btn">Thêm vào giỏ</a>
            </div>
        </div>
        <% } %>
        <% } else { %>
        <p class="text-center">Hiện chưa có sách nào.</p>
        <% } %>
    </div>
</section>
<!-- footer section start -->
<jsp:include page="views/common/footer.jsp" />
<!-- footer section end -->


<!-- Custom JS -->
<script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/script.js"></script>
</body>
</html>