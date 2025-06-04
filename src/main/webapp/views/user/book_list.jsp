<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sách | 4Book</title>
    <!-- Icon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/image/book-shop.png" />

    <!-- Font awesome cdn link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- Custom Css file link -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
</head>
<body>
<!-- header section start -->
<jsp:include page="views/common/header.jsp" />
<!-- header section end -->

<!-- Book List Section -->
<section class="books-list" style="padding: 5rem 9%">
    <h1 class="heading"><span>Tất cả Sách</span></h1>
    <div class="books-grid">
        <c:choose>
            <c:when test="${not empty books}">
                <c:forEach var="book" items="${books}">
                    <div class="book-box">
                        <div class="image">
                            <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookId}">
                                <c:if test="${not empty book.imgUrl}">
                                    <img src="${book.imgUrl}" alt="Ảnh sách" />
                                </c:if>
                            </a>
                        </div>
                        <div class="content">
                            <h3>
                                <a href="${pageContext.request.contextPath}/book-detail?id=${book.bookId}" style="color: inherit; text-decoration: none">
                                        ${book.bookName}
                                </a>
                            </h3>
                            <div class="price">
                                <fmt:formatNumber value="${book.price}" type="number" groupingUsed="true" /> VND
                            </div>
                            <a href="#" class="btn">Thêm vào giỏ</a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-center">Hiện chưa có sách nào.</p>
            </c:otherwise>
        </c:choose>
    </div>
</section>
<!-- footer section start -->
<jsp:include page="views/common/footer.jsp" />
<!-- footer section end -->

<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>