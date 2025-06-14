<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 9:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminpage.css" />
  <title>${book != null ? "Chỉnh sửa sách" : "Thêm sách"}</title>
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

    #loading-overlay {
      position: fixed;
      z-index: 2000;
      top: 0; left: 0;
      width: 100vw; height: 100vh;
      background: rgba(255,255,255,0.7);
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .loading-spinner {
      display: flex;
      flex-direction: column;
      align-items: center;
      font-size: 2rem;
      color: #27ae60;
      gap: 1rem;
    }
    .loading-spinner i {
      font-size: 3rem;
    }

    .error-message {
      margin-top: 0.5rem;
      color: red;
      font-size: 0.9rem;
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
<c:if test="${user != null && user.roleId == 0}">
  <!-- SIDEBAR -->
  <jsp:include page="views/common/sidebar.jsp" />
  <!-- SIDEBAR -->

  <section id="content">
    <!-- NAVBAR -->
    <jsp:include page="views/common/navbar.jsp" />
    <!-- NAVBAR -->
    <main>
      <div class="page-header">
        <h1 class="title">${book != null ? "Chỉnh sửa sách" : "Thêm sách"}</h1>
        <ul class="breadcrumbs">
          <li><a href="${pageContext.request.contextPath}/admin/dashboard">Trang Chủ</a></li>
          <li class="divider">/</li>
          <li><a href="${pageContext.request.contextPath}/admin/books">Quản lý sách</a></li>
          <li class="divider">/</li>
          <li><a href="#" class="active">${book != null ? "Chỉnh sửa sách" : "Thêm sách"}</a></li>
        </ul>

        <div class="actions">
          <a href="${pageContext.request.contextPath}/admin/books" class="btn-back">
            <i class="bx bxs-home"></i> Quay lại danh sách
          </a>
        </div>
      </div>
      <div class="form-container">
        <h1>${book != null ? "Chỉnh sửa sách" : "Thêm sách"}</h1>
        <form method="post" action="books" enctype="multipart/form-data">
          <c:if test="${book != null}">
            <input type="hidden" name="ma_sach" value="${book.bookId}">
          </c:if>
          <div class="form-fields-row">
            <div class="form-fields-col">
              <div class="form-group">
                <label for="ten_sach">Tên sách</label>
                <input type="text" id="ten_sach" name="ten_sach" value="${book != null ? book.bookName : ''}" placeholder="Nhập tên sách" required />
              </div>
              <div class="form-group">
                <label for="tac_gia">Tác giả</label>
                <input type="text" id="tac_gia" name="tac_gia" value="${book != null ? book.author : ''}" placeholder="Nhập tên tác giả" required />
              </div>
              <div class="form-group">
                <label for="nha_xuat_ban">Nhà xuất bản</label>
                <input type="text" id="nha_xuat_ban" name="nha_xuat_ban" value="${book != null ? book.publisher : ''}" placeholder="Nhập nhà xuất bản" required />
              </div>
              <div class="form-group">
                <label for="gia">Giá</label>
                <input type="number" id="gia" name="gia" step="0.01" value="${book != null ? book.price : ''}" placeholder="Nhập giá sách" required />
              </div>
              <div class="form-group">
                <label for="nam_xuat_ban">Năm xuất bản</label>
                <input type="number" id="nam_xuat_ban" name="nam_xuat_ban" value="${book != null ? book.publishYear : ''}" placeholder="Nhập năm xuất bản" required />
              </div>
            </div>
            <div class="form-fields-col">
              <div class="form-group">
                <label for="mo_ta">Mô tả</label>
                <textarea id="mo_ta" name="mo_ta" placeholder="Nhập mô tả sách" required>${book != null ? book.description : ''}</textarea>
              </div>
              <div class="form-group">
                <label for="ma_danh_muc">Danh mục</label>
                <select id="ma_danh_muc" name="ma_danh_muc" required>
                  <option value="">-- Chọn danh mục --</option>
                  <c:forEach var="category" items="${categories}">
                    <option value="${category.categoryId}" ${book != null && category.categoryId == book.categoryId ? 'selected' : ''}>
                        ${category.categoryName}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group">
                <label for="img_url">Ảnh sách</label>
                <c:if test="${book != null && not empty book.imgUrl}">
                  <img src="${book.imgUrl}" alt="Ảnh sách" width="150" /><br />
                </c:if>
                <input type="file" id="img_url" name="img_url" accept="image/*" />
              </div>
            </div>
          </div>

          <div class="form-actions">
            <button type="submit" class="btn btn-submit">${book != null ? "Lưu" : "Tạo sách"}</button>
            <a href="${pageContext.request.contextPath}/admin/books" class="btn btn-cancel">Hủy</a>
          </div>
        </form>
      </div>
    </main>
  </section>

  <div id="loading-overlay" style="display:none;">
    <div class="loading-spinner">
      <i class='bx bx-loader-alt bx-spin'></i>
      <span>Đang xử lý...</span>
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      var form = document.querySelector('.form-container form');
      if (form) {
        form.addEventListener('submit', function (event) {
          // ngan chan submit neu nhap sai
          if (!validateForm()) {
            event.preventDefault();
          } else {
            document.getElementById('loading-overlay').style.display = 'flex';
          }
        });
      }

      function validateForm() {
        var isValid = true;

        var tenSach = document.getElementById('ten_sach');
        var tacGia = document.getElementById('tac_gia');
        var nhaXuatBan = document.getElementById('nha_xuat_ban');
        var gia = document.getElementById('gia');
        var namXuatBan = document.getElementById('nam_xuat_ban');
        var moTa = document.getElementById('mo_ta');
        var maDanhMuc = document.getElementById('ma_danh_muc');

        // xoa error truoc do
        document.querySelectorAll('.error-message').forEach(function (el) {
          el.remove();
        });

        if (!tenSach.value.trim()) {
          showError(tenSach, 'Tên sách không được để trống.');
          isValid = false;
        }

        if (!tacGia.value.trim()) {
          showError(tacGia, 'Tác giả không được để trống.');
          isValid = false;
        }

        if (!nhaXuatBan.value.trim()) {
          showError(nhaXuatBan, 'Nhà xuất bản không được để trống.');
          isValid = false;
        }

        if (!gia.value.trim() || parseFloat(gia.value) <= 0) {
          showError(gia, 'Giá phải là một số dương.');
          isValid = false;
        }

        var currentYear = new Date().getFullYear();
        if (!namXuatBan.value.trim() || parseInt(namXuatBan.value) < 1900 || parseInt(namXuatBan.value) > currentYear) {
          showError(namXuatBan, 'Năm xuất bản phải từ 1900 đến ' + currentYear + '.');
          isValid = false;
        }

        if (!moTa.value.trim()) {
          showError(moTa, 'Mô tả không được để trống.');
          isValid = false;
        }

        if (!maDanhMuc.value.trim()) {
          showError(maDanhMuc, 'Vui lòng chọn danh mục.');
          isValid = false;
        }

        return isValid;
      }

      function showError(input, message) {
        var error = document.createElement('div');
        error.className = 'error-message';
        error.style.color = 'red';
        error.style.fontSize = '0.9rem';
        error.textContent = message;
        input.parentElement.appendChild(error);
      }
    });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
  <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</c:if>
<c:if test="${user == null || user.roleId != 0}">
  <p>Bạn không có quyền truy cập vào trang này.</p>
</c:if>
</body>
</html>