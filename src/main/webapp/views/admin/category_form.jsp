<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Category" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
    Category category = (Category) request.getAttribute("category");
    boolean isEdit = category != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link
            href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/adminpage.css" />
    <title><%= isEdit ? "Chỉnh sửa Danh mục" : "Thêm Danh mục" %></title>
    <style>
        .form-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #fff;
        }

        .form-container h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.8rem;
            color: #333;
        }

        .form-group {
            display: flex;
            flex-direction: column; /* Đảm bảo label và input xếp chồng nhau */
            align-items: flex-start; /* Căn label và input theo chiều dọc */
            margin-bottom: 1.5rem;
        }

        .form-group label {
            width: 100%; /* Đảm bảo label chiếm toàn bộ chiều rộng */
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #333;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%; /* Đảm bảo input, select, textarea chiếm toàn bộ chiều rộng */
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box; /* Đảm bảo padding không làm tăng kích thước */
        }
        .form-group input[type="file"] {
            padding: 0.4rem;
        }

        .form-actions {
            margin-top: 1.5rem; /* Tăng khoảng cách giữa các trường và nút hành động */
            display: flex;
            justify-content: space-between;
            gap: 1.5rem; /* Tăng khoảng cách giữa các nút */
        }

        .btn {
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-submit {
            background: #27ae60;
        }

        .btn-submit:hover {
            background: #219150;
        }

        .btn-cancel {
            background: #e74c3c;
        }

        .btn-cancel:hover {
            background: #c0392b;
        }

        .actions {
            margin-top: 1rem; /* Tăng khoảng cách giữa breadcrumb và nút */
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            background: #3498db;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .btn-back:hover {
            background: #2980b9;
        }

        @media screen and (max-width: 768px) {
            /* Form Container */
            .form-container {
                padding: 1rem; /* Giảm padding để tiết kiệm không gian */
                margin: 1rem; /* Giảm khoảng cách bên ngoài */
            }

            .form-container h1 {
                font-size: 1.5rem; /* Giảm kích thước tiêu đề */
                margin-bottom: 1rem; /* Giảm khoảng cách dưới tiêu đề */
            }

            /* Form Group */
            .form-group {
                margin-bottom: 1rem; /* Giảm khoảng cách giữa các trường */
            }

            .form-group label {
                font-size: 0.9rem; /* Giảm kích thước chữ của label */
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                font-size: 0.9rem; /* Giảm kích thước chữ của input */
                padding: 0.6rem; /* Giảm padding để tiết kiệm không gian */
            }

            /* Form Actions */
            .form-actions {
                flex-direction: column; /* Xếp nút theo chiều dọc */
                gap: 0.8rem; /* Tăng khoảng cách giữa các nút */
            }

            .btn {
                width: 100%; /* Nút chiếm toàn bộ chiều rộng */
                text-align: center;
            }

            /* Breadcrumb and Back Button */
            .actions {
                margin-top: 1rem; /* Tăng khoảng cách giữa breadcrumb và nút */
            }

            .btn-back {
                font-size: 0.9rem; /* Giảm kích thước chữ của nút */
                padding: 0.6rem 1rem; /* Giảm padding của nút */
            }
        }
    </style>
</head>
<body>
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
            <a href="<%= request.getContextPath() %>/admin/books"
            ><i class="bx bxs-book icon"></i> Quản lý sách</a
            >
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/categories" class="active"
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
    <main>
        <div class="page-header">
            <h1 class="title"><%= isEdit ? "Chỉnh sửa Danh mục" : "Thêm Danh mục" %></h1>
            <ul class="breadcrumbs">
                <li><a href="<%= request.getContextPath() %>/admin/dashboard">Home</a></li>
                <li class="divider">/</li>
                <li><a href="#" class="active"><%= isEdit ? "Chỉnh sửa Danh mục" : "Thêm Danh mục" %></a></li>
            </ul>
            <div class="actions">
                <a href="<%= request.getContextPath() %>/admin/categories" class="btn-back">
                    <i class="bx bxs-home"></i> Quay lại danh sách
                </a>
            </div>
        </div>
        <div class="form-container">
            <h1><%= isEdit ? "Chỉnh sửa Danh mục" : "Thêm Danh mục" %></h1>
            <form method="post" action="<%= request.getContextPath() %>/admin/categories">
                <% if (isEdit) { %>
                <input type="hidden" name="ma_danh_muc" value="<%= category.getCategoryId() %>" />
                <% } %>
                <div class="form-group">
                    <label for="ten_danh_muc">Tên danh mục</label>
                    <input
                            type="text"
                            id="ten_danh_muc"
                            name="ten_danh_muc"
                            value="<%= isEdit ? category.getCategoryName() : "" %>"
                            placeholder="Nhập tên danh mục"
                            required
                    />
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-submit"><%= isEdit ? "Cập nhật" : "Thêm mới" %></button>
                    <a href="<%= request.getContextPath() %>/admin/categories" class="btn btn-cancel">Hủy</a>
                </div>
            </form>
        </div>
    </main>
</section>
</body>
</html>