<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("login.jsp"); // Redirect if not logged in
    return;
  }
%>
<%!
  public String safe(String input) {
    return input != null ? input : "";
  }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thông tin cá nhân - 4Book</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
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
      font-size: 1.2rem;
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
      font-size: 1.8rem;
      color: #27ae60;
      margin-bottom: 1.5rem;
    }

    .profile-form .form-group {
      margin-bottom: 1.5rem;
    }

    .profile-form .form-group label {
      font-size: 1.2rem;
      color: #444;
      margin-bottom: 0.5rem;
      display: block;
    }

    .profile-form .form-group input {
      width: 100%;
      padding: 0.8rem;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 1.1rem;
    }

    .profile-save-btn {
      display: block;
      width: 100%;
      padding: 1rem;
      background: #27ae60;
      color: #fff;
      border: none;
      border-radius: 5px;
      font-size: 1.2rem;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.2s;
    }

    .profile-save-btn:hover {
      background: #219150;
    }

    /* Responsive for mobile */
    @media (max-width: 600px) {
      .profile-layout {
        margin: 1rem;
      }

      .profile-menu a {
        font-size: 1.1rem;
      }

      .profile-avatar {
        width: 90px;
        height: 90px;
      }

      .profile-info-section h2 {
        font-size: 1.5rem;
      }

      .profile-form .form-group input {
        font-size: 1.1rem;
      }

      .profile-form .form-group label {
        font-size: 1.2rem;
      }

      .profile-save-btn {
        font-size: 1.2rem;
      }
    }
  </style>
</head>
<body>

<!-- header section start -->
<jsp:include page="views/common/header.jsp" />
<!-- header section end -->

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
      <img src="<%= safe(user.getAvatarUrl() != null ? user.getAvatarUrl() : request.getContextPath() + "/image/avatar_default.png") %>" alt="Avatar" class="profile-avatar" />
    </div>
    <div class="profile-info-section">
      <h2>Hồ sơ cá nhân</h2>

      <% if ("1".equals(request.getParameter("success"))) { %>
      <script>
        $(document).ready(function() {
          toastr.success('Cập nhật thành công!');
        });
      </script>
      <% } else if ("1".equals(request.getParameter("error"))) { %>
      <script>
        $(document).ready(function() {
          toastr.error('Cập nhật thất bại. Vui lòng thử lại!');
        });
      </script>
      <% } %>

      <form class="profile-form" action="<%= request.getContextPath() %>/update-profile" method="post" enctype="multipart/form-data">
        <div class="form-group">
          <label>Họ và Tên</label>
          <input type="text" name="name" value="<%= user.getName() %>" required />
        </div>
        <div class="form-group">
          <label>Email</label>
          <input type="email" name="email" value="<%= user.getEmail() %>" readonly />
        </div>
        <div class="form-group">
          <label>Số điện thoại</label>
          <input type="text" name="phone" value="<%= safe(user.getPhoneNumber()) %>" />
        </div>
        <div class="form-group">
          <label>Địa chỉ</label>
          <input type="text" name="address" value="<%= safe(user.getAddress()) %>" />
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

<!-- footer section start -->
<jsp:include page="views/common/footer.jsp" />
<!-- footer section end -->

</body>
</html>