<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 9:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminpage.css" />
    <title>Quản lý sách</title>
    <style>
        /* Page Header */
        .page-header {
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .page-header .actions {
            display: flex;
            gap: 10px; /* Khoảng cách giữa các nút */
        }

        .page-header .btn-create,
        .page-header .btn-back {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
        }

        .page-header .btn-create {
            background: #27ae60;
        }

        .page-header .btn-create:hover {
            background: #219150;
        }

        .page-header .btn-back {
            background: #3498db;
        }

        .page-header .btn-back:hover {
            background: #2980b9;
        }
        /* Head Section */
        .head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .head .actions a {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            margin-left: 10px;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
        }

        .head .btn-create {
            background: #27ae60;
        }

        .head .btn-create:hover {
            background: #219150;
        }

        .head .btn-back {
            background: #3498db;
        }

        .head .btn-back:hover {
            background: #2980b9;
        }

        /* Table */
        .table-container {
            width: 100%;
            overflow-x: auto; /* Cho phép cuộn ngang */
            margin-top: 1rem;
            border: 1px solid #ddd; /* Tùy chọn: thêm viền cho container */
            border-radius: 5px; /* Tùy chọn: bo góc container */
            white-space: nowrap; /* Đảm bảo bảng không bị xuống dòng */
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px; /* Đặt chiều rộng tối thiểu để tạo thanh cuộn nếu cần */
        }
        .data-table th,
        .data-table td {
            border: 1px solid #ddd;
            padding: 0.8rem;
            text-align: left;
        }

        .data-table th {
            background: #f4f4f4;
        }

        .data-table td {
            background: #fff;
        }


        .data-table td.description-cell {
            max-width: 500px;    /* Tăng chiều rộng tối đa */
            min-width: 250px;
            white-space: normal;
            word-break: break-word;
        }
        .btn-edit {
            background: #f39c12;
            color: #fff;
            padding: 0.3rem 0.6rem;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .btn-edit:hover {
            background: #e67e22;
        }

        .btn-delete {
            background: #e74c3c;
            color: #fff;
            padding: 0.3rem 0.6rem;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .btn-delete:hover {
            background: #c0392b;
        }

        .book-img {
            max-width: 80px;
            max-height: 100px;
            object-fit: cover;
            border-radius: 6px;
            display: block;
            margin: 0 auto;
        }

        .modal {
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5);
            display: flex; justify-content: center; align-items: center;
        }

        /* Modal Content */
        .modal-content {
            background-color: #fff;
            padding: 2rem 1.5rem 1.5rem 1.5rem;
            border-radius: 12px;
            width: 90%;
            max-width: 380px;
            text-align: center;
            position: relative;
            box-shadow: 0 8px 32px rgba(44,62,80,0.15);
            animation: modalFadeIn 0.2s;
        }

        @keyframes modalFadeIn {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Close Button */
        .close {
            position: absolute;
            top: 14px;
            right: 18px;
            font-size: 28px;
            font-weight: bold;
            color: #aaa;
            cursor: pointer;
            transition: color 0.2s;
        }
        .close:hover { color: #e74c3c; }

        /* Icon */
        .modal-icon {
            font-size: 48px;
            color: #e74c3c;
            margin-bottom: 0.5rem;
        }

        /* Title */
        .modal-content h2 {
            margin: 0 0 0.5rem 0;
            color: #e74c3c;
            font-size: 1.4rem;
            font-weight: bold;
        }

        /* Actions */
        .modal-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .btn {
            padding: 0.7rem 1.4rem;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-delete {
            background: #e74c3c;
            color: #fff;
        }
        .btn-delete:hover {
            background: #c0392b;
        }

        .btn-cancel {
            background: #bdc3c7;
            color: #333;
        }
        .btn-cancel:hover {
            background: #95a5a6;
        }

        .toast {
            position: fixed;
            top: 20px; /* Move to the top */
            right: 20px; /* Align to the right */
            background-color: #27ae60;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            font-size: 1rem;
            z-index: 1000;
            animation: fadeInOut 3s ease-in-out;
        }

        @keyframes fadeInOut {
            0%, 100% { opacity: 0; }
            10%, 90% { opacity: 1; }
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
        /* Responsive for mobile */
        @media screen and (max-width: 768px) {
            /* Thu hẹp khoảng cách nội dung */
            #content {
                margin-left: 0;
                padding: 1rem;
            }

            /* Page Header */
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .page-header .actions {
                display: flex;
                flex-direction: column;
                gap: 0.5rem; /* Khoảng cách giữa các nút */
                width: 100%;
            }

            .page-header .btn-create,
            .page-header .btn-back {
                width: 100%; /* Nút chiếm toàn bộ chiều rộng */
                justify-content: center;
            }

            .table-container {
                width: 100%;
                overflow-x: auto; /* Cho phép cuộn ngang */
                margin-top: 1rem;
                border: 1px solid #ddd; /* Tùy chọn: thêm viền cho container */
                border-radius: 5px; /* Tùy chọn: bo góc container */
                white-space: nowrap; /* Đảm bảo bảng không bị xuống dòng */
                -webkit-overflow-scrolling: touch;
            }
            /* Table */
            .data-table {
                display: block;
                overflow-x: auto;
                width: 100%;
                min-width: 800px;
            }

            .data-table th,
            .data-table td {
                border: 1px solid #ddd;
                padding: 0.8rem;
                text-align: left;
            }

            .data-table th {
                font-size: 0.9rem; /* Giảm kích thước chữ tiêu đề */
            }

            .data-table td {
                font-size: 0.85rem; /* Giảm kích thước chữ nội dung */
                word-wrap: break-word; /* Đảm bảo nội dung không tràn */
            }

            .data-table td .action-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 0.3rem;
            }

            .action-buttons {
                display: flex;
                flex-direction: column;
                align-items: stretch;
            }

            /* Nút hành động */
            .btn-edit,
            .btn-delete {
                padding: 0.3rem 0.5rem;
                font-size: 0.8rem;
                display: inline-block;
                margin: 0.2rem 0; /* Tạo khoảng cách giữa các nút */
                width: 100%; /* Nút chiếm toàn bộ chiều rộng */
                text-align: center;
            }

            .btn-edit {
                background: #f39c12;
                color: #fff;
                border-radius: 3px;
            }

            .btn-edit:hover {
                background: #e67e22;
            }

            .btn-delete {
                background: #e74c3c;
                color: #fff;
                border-radius: 3px;
            }

            .btn-delete:hover {
                background: #c0392b;
            }

            main,
            section,
            #content {
                width: 100%;
                overflow-x: visible;
            }
        }
    </style>
</head>
<body>
<c:if test="${user != null && user.roleId == 0}">
    <!-- SIDEBAR -->
    <jsp:include page="views/common/sidebar.jsp" />
    <!-- NAVBAR -->
    <section id="content">
        <jsp:include page="views/common/navbar.jsp" />
        <main>
            <div class="page-header">
                <h1 class="title">Quản lý sách</h1>
                <ul class="breadcrumbs">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Trang Chủ</a></li>
                    <li class="divider">/</li>
                    <li><a href="#" class="active">Quản lý sách</a></li>
                </ul>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/admin/books?action=add" class="btn-create">
                        <i class="bx bxs-plus-circle"></i> Tạo sách mới
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
                        <i class="bx bxs-home"></i> Quay lại trang chính
                    </a>
                </div>
            </div>
            <c:set var="booksPerPage" value="5" />
            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
            <c:set var="totalBooks" value="${fn:length(books)}" />
            <c:set var="totalPages" value="${(totalBooks / booksPerPage) + (totalBooks % booksPerPage > 0 ? 1 : 0)}" />
            <c:set var="startIndex" value="${(currentPage - 1) * booksPerPage}" />
            <c:set var="endIndex" value="${startIndex + booksPerPage > totalBooks ? totalBooks : startIndex + booksPerPage}" />
            <c:set var="paginatedBooks" value="${books.subList(startIndex, endIndex)}" />
            <div class="table-container">
                <table class="data-table">
                    <thead>
                    <tr>
                        <th>Ảnh sách</th>
                        <th>Tên sách</th>
                        <th>Tác giả</th>
                        <th>NXB</th>
                        <th>Năm XB</th>
                        <th>Giá</th>
                        <th>Mô tả</th>
                        <th>Danh mục</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="book" items="${paginatedBooks}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty book.imgUrl}">
                                        <img class="book-img" src="${book.imgUrl}" alt="Ảnh sách" />
                                    </c:when>
                                    <c:otherwise>Chưa có ảnh</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${book.bookName}</td>
                            <td>${book.author}</td>
                            <td>${book.publisher}</td>
                            <td>${book.publishYear}</td>
                            <td>${book.price} VND</td>
                            <td class="description-cell">
                                <c:choose>
                                    <c:when test="${fn:length(book.description) > 100}">
                                        ${fn:substring(book.description, 0, 100)}...
                                    </c:when>
                                    <c:otherwise>${book.description}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${categoryMap[book.categoryId]}</td>
                            <td>
                                <div class="action-buttons">
                                    <a class="btn-edit" href="books?action=edit&id=${book.bookId}">Sửa</a>
                                    <button class="btn-delete" onclick="showDeleteModal(${book.bookId})">Xóa</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}" class="arrow" title="Trang trước">&#60;</a>
                </c:if>
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="active">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}" class="arrow" title="Trang sau">&#62;</a>
                </c:if>
            </div>
        </main>
    </section>
    <div id="deleteModal" class="modal" style="display:none;">
        <div class="modal-content">
            <span class="close" onclick="closeModal()" title="Đóng">&times;</span>
            <div class="modal-icon">
                <i class="bx bxs-error-circle"></i>
            </div>
            <h2>Xác nhận xóa</h2>
            <p>Bạn có chắc chắn muốn xóa sách này không?</p>
            <form id="deleteForm" method="post" action="">
                <input type="hidden" name="action" value="delete" />
                <div class="modal-actions">
                    <button type="submit" class="btn btn-delete">Xác nhận xóa</button>
                    <button type="button" class="btn btn-cancel" onclick="closeModal()">Hủy</button>
                </div>
            </form>
        </div>
    </div>
    <div id="toast" class="toast" style="display: none;">
        <p id="toastMessage"></p>
    </div>
    <script>
        function showDeleteModal(bookId) {
            const modal = document.getElementById('deleteModal');
            const form = document.getElementById('deleteForm');
            form.action = '${pageContext.request.contextPath}/admin/books?action=delete&id=' + bookId;
            modal.style.display = 'flex';
        }
        function closeModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
        window.onload = function () {
            const toastMessage = '${sessionScope.toastMessage}';
            if (toastMessage) {
                const toast = document.getElementById('toast');
                const toastText = document.getElementById('toastMessage');
                toastText.textContent = toastMessage;
                toast.style.display = 'block';

                // Clear the toastMessage session attribute
                fetch('${pageContext.request.contextPath}/admin/books?action=clearToastMessage', { method: 'POST' });

                setTimeout(() => {
                    toast.style.display = 'none';
                }, 3000);
            }
        };
    </script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</c:if>
<c:if test="${user == null || user.roleId != 0}">
    <p>Bạn không có quyền truy cập vào trang này.</p>
</c:if>
</body>
</html>