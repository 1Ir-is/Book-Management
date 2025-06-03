<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 9:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Book" %>
<%@ page import="models.Category" %>
<%@ page import="models.User" %>
<%@ page import="java.util.List" %>

<%
  User user = (User) session.getAttribute("user");
  Book book = (Book) request.getAttribute("book");
  List<Category> categories = (List<Category>) request.getAttribute("categories");
  boolean isEdit = book != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/adminpage.css" />
  <title><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách" %></title>
  <style>
    .form-container {
      max-width: 1000px;      /* Giới hạn chiều ngang, bạn có thể thử 900px nếu cần gọn hơn nữa */
      margin: 2rem auto;      /* Căn giữa form */
      padding: 2rem 3rem;     /* Padding bên trong */
      border: 1px solid #ddd;
      border-radius: 8px;
      background: #fff;
      box-sizing: border-box;
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

    .form-fields-row {
      display: flex;
      gap: 3rem; /* Tăng khoảng cách giữa 2 cột */
    }
    .form-fields-col {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
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
      .form-fields-row {
        flex-direction: column;
        gap: 0;
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
      <a href="<%= request.getContextPath() %>/admin/dashboard"><i class="bx bxs-dashboard icon"></i> Dashboard</a>
    </li>
    <li class="divider" data-text="Management">Management</li>
    <li>
      <a href="<%= request.getContextPath() %>/admin/books" class="active"><i class="bx bxs-book icon"></i> Quản lý sách</a>
    </li>
    <li>
      <a href="<%= request.getContextPath() %>/admin/categories"><i class="bx bxs-category icon"></i> Quản lý thể loại</a>
    </li>
    <li>
      <a href="<%= request.getContextPath() %>/admin/users"><i class="bx bxs-user icon"></i> Quản lý người dùng</a>
    </li>
    <li>
      <a href="<%= request.getContextPath() %>/admin/orders"><i class="bx bxs-cart icon"></i> Quản lý đơn hàng</a>
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
      <img src="https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg" alt="" />
      <ul class="profile-link">
        <li><a href="#"><i class="bx bxs-user-circle icon"></i> Profile</a></li>
        <li><a href="#"><i class="bx bxs-cog"></i> Settings</a></li>
        <li><a href="<%= request.getContextPath() %>/logout"><i class="bx bxs-log-out-circle"></i> Logout</a></li>
      </ul>
    </div>
  </nav>

  <main>
    <div class="page-header">
      <h1 class="title"><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách" %></h1>
      <ul class="breadcrumbs">
        <li><a href="<%= request.getContextPath() %>/admin/dashboard">Home</a></li>
        <li class="divider">/</li>
        <li><a href="<%= request.getContextPath() %>/admin/books">Quản lý sách</a></li>
        <li class="divider">/</li>
        <li><a href="#" class="active"><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách" %></a></li>
      </ul>

      <div class="actions">
        <a href="<%= request.getContextPath() %>/admin/books" class="btn-back">
          <i class="bx bxs-home"></i> Quay lại danh sách
        </a>
      </div>
    </div>
    <div class="form-container">
      <h1><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách" %></h1>
      <form method="post" action="books" enctype="multipart/form-data">
        <% if (isEdit) { %>
        <input type="hidden" name="ma_sach" value="<%= book.getBookId() %>">
        <% } %>
        <div class="form-fields-row">
          <div class="form-fields-col">
            <div class="form-group">
              <label for="ten_sach">Tên sách</label>
              <input type="text" id="ten_sach" name="ten_sach" value="<%= isEdit ? book.getBookName() : "" %>" placeholder="Nhập tên sách" required />
            </div>
            <div class="form-group">
              <label for="tac_gia">Tác giả</label>
              <input type="text" id="tac_gia" name="tac_gia" value="<%= isEdit ? book.getAuthor() : "" %>" placeholder="Nhập tên tác giả" required />
            </div>
            <div class="form-group">
              <label for="nha_xuat_ban">Nhà xuất bản</label>
              <input type="text" id="nha_xuat_ban" name="nha_xuat_ban" value="<%= isEdit ? book.getPublisher() : "" %>" placeholder="Nhập nhà xuất bản" required />
            </div>
            <div class="form-group">
              <label for="gia">Giá</label>
              <input type="number" id="gia" name="gia" step="0.01" value="<%= isEdit ? book.getPrice() : "" %>" placeholder="Nhập giá sách" required />
            </div>
          </div>
          <div class="form-fields-col">
            <div class="form-group">
              <label for="mo_ta">Mô tả</label>
              <textarea id="mo_ta" name="mo_ta" placeholder="Nhập mô tả sách" required><%= isEdit ? book.getDescription() : "" %></textarea>
            </div>
            <div class="form-group">
              <label for="ma_danh_muc">Danh mục</label>
              <select id="ma_danh_muc" name="ma_danh_muc" required>
                <option value="">-- Chọn danh mục --</option>
                <% for (Category c : categories) { %>
                <option value="<%= c.getCategoryId() %>" <%= isEdit && c.getCategoryId() == book.getCategoryId() ? "selected" : "" %>>
                  <%= c.getCategoryName() %>
                </option>
                <% } %>
              </select>
            </div>
            <div class="form-group">
              <label for="img_url">Ảnh sách</label>
              <% if (isEdit && book.getImgUrl() != null && !book.getImgUrl().isEmpty()) { %>
              <img src="<%= book.getImgUrl() %>" alt="Ảnh sách" width="150" /><br />
              <% } %>
              <input type="file" id="img_url" name="img_url" accept="image/*" />
            </div>
          </div>
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-submit"><%= isEdit ? "Lưu" : "Tạo sách" %></button>
          <a href="<%= request.getContextPath() %>/admin/books" class="btn btn-cancel">Hủy</a>
        </div>
      </form>
    </div>
  </main>
</section>
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