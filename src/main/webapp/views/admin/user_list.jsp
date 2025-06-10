<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fnc" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminpage.css" />
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
            overflow-x: auto;
            margin-top: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
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

        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0, 0, 0, 0.5); /* Black background with opacity */
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 90%; /* Adjust width */
            max-width: 400px; /* Limit max width */
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .modal-icon {
            font-size: 3rem;
            color: #e74c3c;
            margin-bottom: 1rem;
        }

        .modal-actions {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 1rem;
        }

        .modal-actions .btn {
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .modal-actions .btn-delete {
            background-color: #e74c3c;
            color: #fff;
        }

        .modal-actions .btn-delete:hover {
            background-color: #c0392b;
        }

        .modal-actions .btn-cancel {
            background-color: #3498db;
            color: #fff;
        }

        .modal-actions .btn-cancel:hover {
            background-color: #2980b9;
        }

        .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 1.5rem;
            color: #333;
            cursor: pointer;
        }

        .close:hover {
            color: #e74c3c;
        }
        /* Toast Message */
        #toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #27ae60;
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 5px;
            z-index: 2000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            font-size: 1rem;
            animation: fadeInOut 3s ease-in-out;
        }

        /* Animation */
        @keyframes fadeInOut {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            10% {
                opacity: 1;
                transform: translateY(0);
            }
            90% {
                opacity: 1;
                transform: translateY(0);
            }
            100% {
                opacity: 0;
                transform: translateY(-20px);
            }
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

        .search-form {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-form input {
            padding: 0.5rem;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 250px;
            transition: border-color 0.3s ease-in-out;
        }

        .search-form input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
        }

        .search-form button {
            padding: 0.5rem 1rem;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            background-color: #27ae60;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out;
        }

        .search-form button:hover {
            background-color: #219150;
            transform: scale(1.05);
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
                overflow-x: auto;
                margin-top: 1rem;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            /* Table */
            .data-table {
                width: 100%;
                border-collapse: collapse;
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
                overflow-x: hidden;
            }
        }
    </style>
    <title>Quản lý người dùng</title>
</head>
<body>

<!-- SIDEBAR -->
<jsp:include page="views/common/sidebar.jsp" />
<!-- SIDEBAR -->

<section id="content">
    <!-- NAVBAR -->
    <jsp:include page="views/common/navbar.jsp" />
    <!-- NAVBAR -->
    <main>
        <div class="page-header">
            <h1 class="title">Quản lý người dùng</h1>
            <ul class="breadcrumbs">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Trang Chủ</a></li>
                <li class="divider">/</li>
                <li><a href="#" class="active">Quản lý người dùng</a></li>
            </ul>
            <div class="actions">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
                    <i class="bx bxs-home"></i> Quay lại trang chính
                </a>
            </div>
        </div>
        <form class="search-form" action="${pageContext.request.contextPath}/admin/users" method="get">
            <input type="text" name="keyword" value="${keyword}" placeholder="Tìm theo tên hoặc email" />
            <button type="submit">Tìm kiếm</button>
        </form>

        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Tên</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Địa chỉ</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty users}">
                        <tr>
                            <td colspan="6" style="text-align: center; font-style: italic; color: #888;">
                                Không tìm thấy người dùng nào.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="user" items="${users}">
                            <c:if test="${user.roleId != 0}">
                                <tr>
                                    <td>${user.name}</td>
                                    <td>${user.email}</td>
                                    <td>${user.phoneNumber}</td>
                                    <td>${user.address}</td>
                                    <td>${user.status ? "Hoạt động" : "Bị khóa"}</td>
                                    <td>
                                        <c:if test="${user.status}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                <input type="hidden" name="userId" value="${user.userId}" />
                                                <input type="hidden" name="action" value="block" />
                                                <button
                                                        type="button"
                                                        class="btn-delete"
                                                        data-user-id="${user.userId}"
                                                        onclick="showDeleteModalFromButton(this)">Khóa</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${!user.status}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/users" style="display:inline;">
                                                <input type="hidden" name="userId" value="${user.userId}" />
                                                <input type="hidden" name="action" value="unblock" />
                                                <button type="submit" class="btn-edit">Mở khóa</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>

            </table>
        </div>
        <c:if test="${totalPages > 1}">
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
        </c:if>

    </main>
</section>

<!-- Modal xác nhận xóa -->
<div id="deleteModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close" onclick="closeModal()" title="Đóng">&times;</span>
        <div class="modal-icon">
            <i class="bx bxs-error-circle"></i>
        </div>
        <h2>Xác nhận khoá tài khoản</h2>
        <p id="deleteMessage">Bạn có chắc chắn muốn khóa người dùng này không?</p>
        <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/admin/users">
            <input type="hidden" name="action" value="block">
            <input type="hidden" name="userId" id="deleteUserId" value="">
            <div class="modal-actions">
                <button type="submit" class="btn btn-delete">Xác nhận khóa</button>
                <button type="button" class="btn btn-cancel" onclick="closeModal()">Hủy</button>
            </div>
        </form>
    </div>
</div>

<!-- Toast Message -->
<div id="toast" class="toast" style="display: none;">
    <p id="toastMessage"></p>
</div>
<c:if test="${not empty toastMessage}">
    <script>
        window.onload = function () {
            const toastMessage = "${toastMessage}";
            const toast = document.getElementById('toast');
            const toastText = document.getElementById('toastMessage');
            toastText.textContent = toastMessage;
            toast.style.display = 'block';
            setTimeout(() => {
                toast.style.display = 'none';
            }, 3000);
        };
    </script>
</c:if>

<script>
    function showDeleteModalFromButton(button) {
        const userId = button.getAttribute('data-user-id');
        showDeleteModal(userId);
    }

    function showDeleteModal(userId) {
        const modal = document.getElementById('deleteModal');
        const input = document.getElementById('deleteUserId');
        const message = document.getElementById('deleteMessage');
        input.value = userId;
        message.textContent = `Bạn có chắc chắn muốn khóa tài khoản của người dùng này không?`;
        modal.style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('deleteModal').style.display = 'none';
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>