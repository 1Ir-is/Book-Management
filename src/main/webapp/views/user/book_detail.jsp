<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Map" %>
<%@ page import="models.Book" %>
<%
    request.setAttribute("categoryMap", request.getAttribute("categoryMap"));
%>
<%
    Book book = (Book) request.getAttribute("book");
    Map<Integer, String> categoryMap = (Map<Integer, String>) request.getAttribute("categoryMap");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sách | 4Book</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
     <style>
        /* Fahasa style desktop detail */
        .book-detail-fahasa-desktop {
            background: #f5f5f7;
            min-height: 100vh;
            padding: 32px 0;
        }
        .book-detail-main {
            display: flex;
            max-width: 1200px;
            margin: 0 auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 32px #0001;
            padding: 32px 32px 40px 32px;
            gap: 40px;
        }
        .book-detail-left {
            flex: 1.1;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .book-main-img {
            width: 340px;
            max-width: 100%;
            border-radius: 12px;
            box-shadow: 0 2px 16px #0002;
            margin-bottom: 18px;
            background: #fff;
        }
        .book-thumb-list {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
        }
        .book-thumb {
            width: 64px;
            height: 64px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #eee;
            background: #fff;
            cursor: pointer;
            transition: border 0.2s;
        }
        .book-thumb:hover {
            border: 2px solid #27ae60;
        }
        .add-cart-btn-desktop {
            width: 90%;
            background: #27ae60;
            color: #fff;
            font-size: 1.25rem;
            font-weight: 600;
            border: none;
            border-radius: 24px;
            padding: 1.2rem 0;
            box-shadow: 0 2px 8px #c9212733;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 12px;
        }
        .add-cart-btn-desktop:hover {
            background: #219150;
        }
        .book-detail-right {
            flex: 1.5;
            background: #fff;
            border-radius: 12px;
            padding: 18px 24px;
            box-shadow: 0 2px 8px #0001;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
        }
        .book-title-desktop {
            font-size: 2.8rem;
            font-weight: 700;
            color: #222;
            margin-bottom: 1.5rem;
        }
        .book-table-desktop {
            width: 100%;
            font-size: 1.45rem;
            margin-bottom: 1.5rem;
            border-collapse: collapse;
        }
        .book-table-desktop td {
            padding: 1rem 0.7rem;
            border-bottom: 1px solid #f0f0f0;
            color: #222;
            font-size: 1.25rem;
        }
        .book-table-desktop td:first-child {
            color: #888;
            width: 32%;
            font-weight: 500;
        }
        .book-desc-desktop {
            background: #f9f9f9;
            border-radius: 8px;
            padding: 1.3rem 1.2rem;
            font-size: 1.22rem;
            color: #444;
            margin-bottom: 1.2rem;
            line-height: 1.6;
            text-align: justify;
        }

        .book-price-desktop {
            color: #27ae60;
            font-size: 2.2rem;
            font-weight: bold;
            margin-bottom: 1.2rem;
        }

        .book-currency {
            font-size: 1.5rem;
            color: #888;
            margin-left: 0.3rem;
        }
        @media (max-width: 991px) {
            .book-detail-main {
                flex-direction: column;
                padding: 18px 6px;
                gap: 18px;
            }
            .book-detail-right {
                padding: 12px 6px;
            }
            .book-main-img {
                width: 220px;
            }
        }

        @media (max-width: 600px) {
            .book-title-desktop {
                font-size: 3.2rem;
                margin-bottom: 2rem;
            }
            .book-table-desktop {
                font-size: 2.1rem;
            }
            .book-table-desktop td {
                font-size: 1.8rem;
                padding: 1.5rem 1rem;
            }
            .book-desc-desktop {
                font-size: 1.7rem;
                padding: 1.5rem 1.2rem;
            }
            .add-cart-btn-desktop {
                font-size: 2rem;
                padding: 2rem 0;
                width: 100%;
                border-radius: 26px;
                margin: 2.5rem 0 2.5rem 0;
            }
            .book-detail-main {
                padding: 10px 2px;
            }
            .book-price-desktop {
                font-size: 2.5rem;
                margin-bottom: 1.5rem;
            }
        }
    </style>
</head>
<body>
<jsp:include page="views/common/header.jsp" />

<section class="book-detail-fahasa-desktop">
    <div class="book-detail-main">
        <div class="book-detail-left">
            <c:if test="${not empty book and not empty book.imgUrl}">
                <img src="${book.imgUrl}" alt="${book.bookName}" class="book-main-img" />
            </c:if>
            <button class="add-cart-btn-desktop">
                <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
            </button>
            <form action="<%= request.getContextPath() %>/cart" method="post" style="margin-top: 10px;">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                <label>Số lượng:</label>
                <input type="number" name="soLuong" value="1" min="1" required>
                <button type="submit">Thêm vào giỏ hàng</button>
            </form>
        </div>
        <div class="book-detail-right">
            <c:if test="${not empty book}">
                <h2 class="book-title-desktop">${book.bookName}</h2>
                <div class="book-price-desktop">
                    <span><fmt:formatNumber value="${book.price}" type="number" groupingUsed="true" /></span> <span class="book-currency">VND</span>
                </div>
                <table class="book-table-desktop">
                    <tr>
                        <td>Nhà Cung Cấp</td>
                        <td>${book.publisher}</td>
                    </tr>
                    <tr>
                        <td>Tác giả</td>
                        <td>${book.author}</td>
                    </tr>
                    <tr>
                        <td>Thể loại</td>
                        <td>${categoryMap[book.categoryId]}</td>
                    </tr>
                    <tr>
                        <td>Năm Xuất Bản</td>
                        <td>${book.publishYear}</td>
                    </tr>
                </table>
                <div class="book-desc-desktop">
                    ${book.description}
                </div>
            </c:if>
            <c:if test="${empty book}">
                <p>Không tìm thấy thông tin sách.</p>
            </c:if>
        </div>
    </div>
</section>

<jsp:include page="views/common/footer.jsp" />

<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
