<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Sách | 4Book</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/image/book-shop.png" />

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />

    <style>
        .toast-message {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #28a745;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            opacity: 0;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }
        .toast-message.show {
            opacity: 1;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 32px;
            gap: 0;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 2px 12px #0001;
            padding: 18px 0;
            min-width: 340px;
        }
        .pagination a,
        .pagination span {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 42px;
            height: 42px;
            margin: 0 4px;
            border-radius: 8px;
            font-size: 1.25rem;
            font-weight: 500;
            color: #6c63ff;
            background: transparent;
            text-decoration: none;
            border: none;
            transition: background 0.2s, color 0.2s;
            cursor: pointer;
            user-select: none;
        }
        .pagination a:hover:not(.active):not(.disabled) {
            background: #f3f3fa;
        }
        .pagination .active,
        .pagination a.active {
            color: #222;
            font-weight: bold;
            border-bottom: 2px solid #6c63ff;
            background: transparent;
            pointer-events: none;
        }
        .pagination .disabled {
            color: #ccc;
            cursor: default;
            pointer-events: none;
            background: transparent;
        }
        .pagination .arrow {
            font-size: 1.4rem;
            color: #6c63ff;
            background: transparent;
            border: none;
            transition: color 0.2s;
            padding: 0;
        }
        .pagination .arrow.disabled {
            color: #e0e0e0;
            cursor: default;
        }
    </style>
</head>
<body>

<!-- Header -->
<jsp:include page="views/common/header.jsp" />

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
                            <form class="add-to-cart-form" action="${pageContext.request.contextPath}/user/cart" data-book-id="${book.bookId}" style="margin-top: 10px;">
                            <button type="submit" class="btn add-to-cart-btn">
                                    <i class="fas fa-shopping-cart"></i> Thêm vào giỏ
                                </button>
                            </form>

                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p class="text-center">Hiện chưa có sách nào.</p>
            </c:otherwise>
        </c:choose>
    </div>
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}&keyword=${keyword}&category=${category}" class="arrow" title="Trang trước">&#60;</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="active">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${i}&keyword=${keyword}&category=${category}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}&keyword=${keyword}&category=${category}" class="arrow" title="Trang sau">&#62;</a>
            </c:if>
        </div>
    </c:if>
</section>

<div id="toast" class="toast-message">Đã thêm vào giỏ hàng!</div>


<!-- Footer -->
<jsp:include page="views/common/footer.jsp" />

<script>

    function showToast(message) {
        const toast = document.getElementById("toast");
        toast.textContent = message;
        toast.classList.add("show");

        setTimeout(() => {
            toast.classList.remove("show");
        }, 3000); // Hiển thị trong 3 giây
    }


    document.addEventListener("DOMContentLoaded", () => {
        const cartCountEl = document.getElementById("cart-count");

        document.querySelectorAll(".add-to-cart-form").forEach(form => {
            form.addEventListener("submit", async (e) => {
                e.preventDefault();
                const bookId = form.getAttribute("data-book-id");

                try {
                    const response = await fetch(form.action || "/user/cart", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded",
                            "X-Requested-With": "XMLHttpRequest" // <-- thêm header để phân biệt
                        },
                        body: new URLSearchParams({
                            action: "add",
                            bookId: bookId,
                            soLuong: 1
                        })
                    });

                    if (response.ok) {
                        await updateCartCount();
                        showToast("Đã thêm vào giỏ hàng!");
                    } else {
                        alert("Thêm vào giỏ thất bại!");
                    }
                } catch (err) {
                    console.error("Lỗi thêm vào giỏ:", err);
                    alert("Lỗi khi thêm vào giỏ hàng!");
                }
            });
        });

        async function updateCartCount() {
            try {
                const response = await fetch("/cart/count");
                if (response.ok) {
                    const data = await response.json();
                    if (cartCountEl) {
                        cartCountEl.textContent = data.count;
                    }
                }
            } catch (err) {
                console.error("Không thể cập nhật số lượng giỏ hàng", err);
            }
        }
    });

</script>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

