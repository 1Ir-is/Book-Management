<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    Book book = (Book) request.getAttribute("book");
    Map<Integer, String> categoryMap = (Map<Integer, String>) request.getAttribute("categoryMap");
    NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sách | 4Book</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
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
            <% if (book != null && book.getImgUrl() != null) { %>
            <img src="<%= book.getImgUrl() %>" alt="<%= book.getBookName() %>" class="book-main-img" />
            <% } %>
            <button class="add-cart-btn-desktop">
                <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
            </button>
        </div>
        <div class="book-detail-right">
            <% if (book != null) { %>
            <h2 class="book-title-desktop"><%= book.getBookName() %></h2>
            <div class="book-price-desktop">
                <span><%= currencyFormat.format(book.getPrice()) %></span> <span class="book-currency">VND</span>
            </div>
            <table class="book-table-desktop">
                <tr>
                    <td>Nhà Cung Cấp</td>
                    <td><%= book.getPublisher() %></td>
                </tr>
                <tr>
                    <td>Tác giả</td>
                    <td><%= book.getAuthor() %></td>
                </tr>
                <tr>
                    <td>Thể loại</td>
                    <td><%= categoryMap.get(book.getCategoryId()) %></td>
                </tr>
                <tr>
                    <td>Năm Xuất Bản</td>
                    <td><%= book.getPublishYear() %></td>
                </tr>
            </table>
            <div class="book-desc-desktop">
                <%= book.getDescription() %>
            </div>
            <% } else { %>
            <p>Không tìm thấy thông tin sách.</p>
            <% } %>
        </div>
    </div>
</section>

<jsp:include page="views/common/footer.jsp" />

<script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/script.js"></script>
</body>
</html>