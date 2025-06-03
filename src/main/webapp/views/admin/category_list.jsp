<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Category" %>
<%@ page import="models.User" %>
<%
  User user = (User) session.getAttribute("user");
  List<Category> categories = (List<Category>) request.getAttribute("categories");
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

  <title>Quản lý thể loại</title>
</head>
<body>

<!-- SIDEBAR -->
<jsp:include page="views/common/sidebar.jsp" />
<!-- SIDEBAR -->


<!-- NAVBAR -->
<section id="content">
  <!-- NAVBAR -->
  <jsp:include page="views/common/navbar.jsp" />
  <!-- NAVBAR -->
  <main>
    <div class="page-header">
      <h1 class="title">Quản lý thể loại</h1>
      <ul class="breadcrumbs">
        <li><a href="<%= request.getContextPath() %>/admin/dashboard">Trang Chủ</a></li>
        <li class="divider">/</li>
        <li><a href="#" class="active">Quản lý thể loại</a></li>
      </ul>
      <div class="actions">
        <a href="<%= request.getContextPath() %>/admin/categories?action=add" class="btn-create">
          <i class="bx bxs-plus-circle"></i> Thêm thể loại mới
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
          <th>ID</th>
          <th>Tên thể loại</th>
          <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <% for (Category c : categories) { %>
        <tr>
          <td><%= c.getCategoryId() %></td>
          <td><%= c.getCategoryName() %></td>
          <td>
            <div class="action-buttons">
              <a class="btn-edit" href="<%= request.getContextPath() %>/admin/categories?action=edit&id=<%= c.getCategoryId() %>">Sửa</a>
              <a class="btn-delete" href="<%= request.getContextPath() %>/admin/categories?action=delete&id=<%= c.getCategoryId() %>" onclick="return confirm('Xóa danh mục này?')">Xóa</a>
            </div>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </main>
</section>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="<%= request.getContextPath() %>/assets/js/script.js"></script>
</body>
</html>