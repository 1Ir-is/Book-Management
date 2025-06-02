<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 9:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
    List<Book> books = (List<Book>) request.getAttribute("books");
    Map<Integer, String> categoryMap = (Map<Integer, String>) request.getAttribute("categoryMap");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
            href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/adminpage.css" />
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
<%
    if (user != null && user.getRoleId() == 0) {
%>
<!-- SIDEBAR -->
<section id="sidebar">
    <a href="#" class="brand"><i class="bx bxs-smile icon"></i> Admin</a>
    <ul class="side-menu">
        <li>
            <a href="<%= request.getContextPath() %>/admin/dashboard"
            ><i class="bx bxs-dashboard icon"></i> Dashboard</a
            >
        </li>
        <li class="divider" data-text="Management">Management</li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/books" class="active"
            ><i class="bx bxs-book icon"></i> Quản lý sách</a
            >
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/categories"
            ><i class="bx bxs-category icon"></i> Quản lý thể loại</a
            >
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/users"
            ><i class="bx bxs-user icon"></i> Quản lý người dùng</a
            >
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/orders"
            ><i class="bx bxs-cart icon"></i> Quản lý đơn hàng</a
            >
        </li>
    </ul>
</section>
<!-- SIDEBAR -->

<!-- NAVBAR -->
<section id="content">
    <!-- NAVBAR -->
    <nav>
        <i class="bx bx-menu toggle-sidebar"></i>
        <form action="#">
            <div class="form-group">
                <input type="text" placeholder="Search..." />
                <i class="bx bx-search icon"></i>
            </div>
        </form>
        <a href="#" class="nav-link">
            <span class="hello-user">Hello, <%= user.getName() %></span>
            <i class="bx bxs-bell icon"></i>
            <span class="badge">5</span>
        </a>
        <a href="#" class="nav-link">
            <i class="bx bxs-message-square-dots icon"></i>
            <span class="badge">8</span>
        </a>
        <span class="divider"></span>
        <div class="profile">
            <img
                    src="https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg"
                    alt=""
            />
            <ul class="profile-link">
                <li>
                    <a href="#"><i class="bx bxs-user-circle icon"></i> Profile</a>
                </li>
                <li>
                    <a href="#"><i class="bx bxs-cog"></i> Settings</a>
                </li>
                <li>
                    <a href="<%= request.getContextPath() %>/logout"><i class="bx bxs-log-out-circle"></i> Logout</a>
                </li>
            </ul>
        </div>
    </nav>
    <!-- NAVBAR -->

    <!-- MAIN -->
    <main>
        <div class="page-header">
            <h1 class="title">Quản lý sách</h1>
            <ul class="breadcrumbs">
                <li><a href="<%= request.getContextPath() %>/admin/dashboard">Home</a></li>
                <li class="divider">/</li>
                <li><a href="#" class="active">Quản lý sách</a></li>
            </ul>

            <div class="actions">
                <a href="<%= request.getContextPath() %>/admin/books?action=add" class="btn-create">
                    <i class="bx bxs-plus-circle"></i> Tạo sách mới
                </a>
                <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn-back">
                    <i class="bx bxs-home"></i> Quay lại trang chính
                </a>
            </div>
        </div>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Ảnh sách</th>
                    <th>Tên sách</th>
                    <th>Tác giả</th>
                    <th>NXB</th>
                    <th>Giá</th>
                    <th>Mô tả</th>
                    <th>Danh mục</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <% for (Book book : books) { %>
                <tr>
                    <td>
                        <% if (book.getImgUrl() != null && !book.getImgUrl().isEmpty()) { %>
                        <img class="book-img" src="<%= book.getImgUrl() %>" alt="Ảnh sách">
                        <% } else { %>
                        <span>Chưa có ảnh</span>
                        <% } %>
                    </td>
                    <td><%= book.getBookName() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td><%= book.getPublisher() %></td>
                    <td><%= book.getPrice() %></td>
                    <td class="description-cell"><%= book.getDescription() %></td>
                    <td><%= categoryMap.get(book.getCategoryId()) %></td>
                    <td>
                        <a class="btn-edit" href="books?action=edit&id=<%= book.getBookId() %>">Sửa</a>
                        <button class="btn-delete" onclick="return confirm('Xóa sách này?')">Xóa</button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </main>
    <!-- MAIN -->
</section>
<!-- NAVBAR -->

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="<%= request.getContextPath() %>/assets/js/script.js"></script>
<%
} else {
%>
<p>Bạn không có quyền truy cập vào trang này.</p>
<%
    }
%>
</body>
</html>