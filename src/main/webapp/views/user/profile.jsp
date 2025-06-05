<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
  models.User user = (models.User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp"); // ✅ KHÔNG dùng ${} trong Java
    return;
  }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thông tin cá nhân - 4Book</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
  <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
  <style>
    /* Container for menu and content */
    .profile-layout {
      display: flex;
      flex-direction: column;
      max-width: 900px;
      margin: 2rem auto;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }

    /* Menu section */
    .profile-menu-container {
      background: #f9f9f9;
      border-bottom: 1px solid #eee;
    }

    .profile-menu {
      display: flex;
      justify-content: space-around;
      padding: 1rem 0;
    }

    .profile-menu a {
      font-size: 1.4rem; /* Increased font size */
      color: #444;
      text-decoration: none;
      padding: 0.5rem 1rem;
      transition: color 0.2s, border-bottom 0.2s;
    }

    .profile-menu a.active {
      color: #27ae60;
      font-weight: bold;
      border-bottom: 2px solid #27ae60;
    }

    .profile-menu a:hover {
      color: #27ae60;
    }

    /* Avatar section */
    .profile-avatar-section {
      display: flex;
      justify-content: center;
      padding: 2rem 0;
      border-bottom: 1px solid #eee;
    }

    .profile-avatar {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      border: 3px solid #27ae60;
      object-fit: cover;
    }

    /* Info section */
    .profile-info-section {
      padding: 2.5rem 2.5rem;
    }

    .profile-info-section h2 {
      font-size: 2rem; /* Increased font size */
      color: #27ae60;
      margin-bottom: 1.5rem;
    }

    .profile-form .form-group {
      margin-bottom: 1.5rem;
    }

    .profile-form .form-group label {
      font-size: 1.4rem; /* Increased font size */
      color: #444;
      margin-bottom: 0.5rem;
      display: block;
    }

    .profile-form .form-group input {
      width: 100%;
      padding: 0.8rem;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 1.3rem; /* Increased font size */
    }

    .profile-save-btn {
      display: block;
      width: 100%;
      padding: 1rem;
      background: #27ae60;
      color: #fff;
      border: none;
      border-radius: 5px;
      font-size: 1.4rem; /* Increased font size */
      font-weight: bold;
      cursor: pointer;
      transition: background 0.2s;
    }

    .profile-save-btn:hover {
      background: #219150;
    }

    .error-message {
      margin-top: 0.5rem;
      color: red;
      font-size: 1.1rem; /* Increased font size */
    }

    /* Responsive for mobile */
    @media (max-width: 600px) {
      .profile-layout {
        margin: 1rem;
      }

      .profile-menu a {
        font-size: 1.3rem; /* Increased font size */
      }

      .profile-avatar {
        width: 90px;
        height: 90px;
      }

      .profile-info-section h2 {
        font-size: 1.8rem; /* Increased font size */
      }

      .profile-form .form-group input {
        font-size: 1.3rem; /* Increased font size */
      }

      .profile-form .form-group label {
        font-size: 1.4rem; /* Increased font size */
      }

      .profile-save-btn {
        font-size: 1.4rem; /* Increased font size */
      }
    }
  </style>
</head>
<body>

<!-- header -->
<jsp:include page="views/common/header.jsp" />

<section class="profile-layout">
  <div class="profile-menu-container">
    <nav class="profile-menu">
      <a class="active" href="#">Thông tin tài khoản</a>
      <a href="#">Lịch sử mua hàng</a>
      <a href="#">Đơn hàng của tôi</a>
    </nav>
  </div>

  <div class="profile-content">
    <div class="profile-avatar-section">
      <c:choose>
        <c:when test="${not empty user.avatarUrl}">
          <img src="${user.avatarUrl}" alt="Avatar" class="profile-avatar" />
        </c:when>
        <c:otherwise>
          <img src="${pageContext.request.contextPath}/image/avatar_default.png" alt="Avatar" class="profile-avatar" />
        </c:otherwise>
      </c:choose>
    </div>

    <div class="profile-info-section">
      <h2>Hồ sơ cá nhân</h2>

      <!-- Toastr alerts -->
      <c:if test="${param.success == '1'}">
        <script>
          $(function () {
            toastr.success('Cập nhật thành công!');
          });
        </script>
      </c:if>
      <c:if test="${param.error == '1'}">
        <script>
          $(function () {
            toastr.error('Cập nhật thất bại. Vui lòng thử lại!');
          });
        </script>
      </c:if>

      <form class="profile-form" action="${pageContext.request.contextPath}/update-profile" method="post" enctype="multipart/form-data">
        <div class="form-group">
          <label>Họ và Tên</label>
          <input type="text" name="name" value="${user.name}" required />
        </div>
        <div class="form-group">
          <label>Email</label>
          <input type="email" name="email" value="${user.email}" readonly />
        </div>
        <div class="form-group">
          <label>Số điện thoại</label>
          <input type="text" name="phone" value="${empty user.phoneNumber ? '' : user.phoneNumber}" />
        </div>
        <div class="form-group">
          <label>Địa chỉ</label>
          <input type="text" name="address" value="${empty user.address ? '' : user.address}" />
        </div>
        <div class="form-group">
          <label>Ảnh đại diện</label>
          <input type="file" name="avatar" accept="image/*" />
        </div>
        <button type="submit" class="profile-save-btn">Lưu thay đổi</button>
      </form>
    </div>
  </div>
</section>

<!-- Loading overlay -->
<div id="loading-overlay" style="display: none;">
  <div class="loading-spinner">
    <i class='bx bx-loader-alt bx-spin'></i>
    Đang xử lý...
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('.profile-form');
    if (form) {
      form.addEventListener('submit', function (e) {
        if (!validateForm()) {
          e.preventDefault();
        } else {
          document.getElementById('loading-overlay').style.display = 'flex';
        }
      });
    }

    function validateForm() {
      let isValid = true;
      const name = document.querySelector('input[name="name"]');
      const phone = document.querySelector('input[name="phone"]');
      const address = document.querySelector('input[name="address"]');

      document.querySelectorAll('.error-message').forEach(el => el.remove());

      if (!name.value.trim()) {
        showError(name, 'Họ và Tên không được để trống.');
        isValid = false;
      }

      const phoneRegex = /^[0-9]{10,15}$/;
      if (!phone.value.trim() || !phoneRegex.test(phone.value)) {
        showError(phone, 'Số điện thoại phải là số và có từ 10 đến 15 chữ số.');
        isValid = false;
      }

      if (!address.value.trim()) {
        showError(address, 'Địa chỉ không được để trống.');
        isValid = false;
      }

      return isValid;
    }

    function showError(input, message) {
      const error = document.createElement('div');
      error.className = 'error-message';
      error.textContent = message;
      input.parentElement.appendChild(error);
    }
  });
</script>

<!-- footer -->
<jsp:include page="views/common/footer.jsp" />

</body>
</html>
