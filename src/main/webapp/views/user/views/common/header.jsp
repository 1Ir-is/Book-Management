<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.User" %>
<%
  User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>4Book - Nhà sách trực tuyến</title>

  <!-- Icon -->
  <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() %>/assets/image/book-shop.png" />

  <!-- Font awesome cdn link -->
  <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />

  <!-- Custom Css file link-->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />

  <!-- Toastr Notifications -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>

<body>
<!-- header section start -->

<header class="header">
  <!-- header 1 -->
  <div class="header-1">
    <a href="<%= request.getContextPath() %>/" class="logo"><i class="fas fa-book"></i> 4Book</a>

    <form action="" class="search-form">
      <input type="search" placeholder="Tìm kiếm ..." id="search-box" />
      <label for="search-box" class="fas fa-search"></label>
    </form>

    <div class="icons">
      <div id="search-btn" class="fas fa-search"></div>
      <a href="#" class="fas fa-heart"></a>
      <a href="<%= request.getContextPath() %>/cart.jsp" class="fas fa-shopping-cart"></a>

      <div class="dropdown">
        <% if (user != null) { %>
        <!-- Đã đăng nhập -->
        <div class="fas fa-user dropbtn"></div>
        <div class="dropdown-content" style="padding: 8px 0; min-width: 180px;">
          <div class="drop-content" style="font-weight: 600; font-size: 14px; padding: 6px 14px; cursor: default; line-height: 1.4;">
            Xin chào,<br />
            <%= user.getName() %>
          </div>

          <div style="height: 1px; background-color: #e0e0e0; margin: 6px 0;"></div>

          <a class="drop-content" href="<%= request.getContextPath() %>/profile.jsp" style="padding: 6px 14px; display: block; text-decoration: none; color: #333; font-size: 13px;">
            Thông tin
          </a>
          <a class="drop-content" href="<%= request.getContextPath() %>/history.jsp" style="padding: 6px 14px; display: block; text-decoration: none; color: #333; font-size: 13px;">
            Lịch sử mua hàng
          </a>
          <a class="drop-content" href="<%= request.getContextPath() %>/logout" style="padding: 6px 14px; display: block; text-decoration: none; color: #333; font-size: 13px;">
            Đăng xuất
          </a>
        </div>

        <% } else { %>
        <!-- Chưa đăng nhập -->
        <div id="login-btn" class="fas fa-user dropbtn"></div>
        <% } %>
      </div>
    </div>
  </div>

  <!-- header 2 -->
  <div class="header-2">
    <nav class="navbar">
      <a class="dropbtn" href="<%= request.getContextPath() %>/books.jsp">Khám phá sách hay</a>
      <div class="dropdown">
        <a class="dropbtn" href="#Category">Thể loại</a>
        <div class="dropdown-content">
          <a class="drop-content" href="#">Kinh dị</a>
          <a class="drop-content" href="#">Lãng mạn</a>
          <a class="drop-content" href="#">Người lớn</a>
        </div>
      </div>
      <a class="dropbtn" href="#reviews">Đánh giá</a>
      <a class="dropbtn" href="#blogs">Blog</a>
    </nav>
  </div>
</header>
<!-- header section end -->

<!-- bottom navbar start-->

<header class="mobile-header">
  <div
          class="mobile-header-logo"
          style="text-align: center; padding-top: 1rem"
  >
    <img src="<%= request.getContextPath() %>/assets/image/book-shop.png" alt="4Book Logo" style="height: 38px" />
  </div>
  <div class="mobile-header-bar">
    <a href="#" class="header-icon-left fas fa-list"></a>
    <form class="mobile-search-form">
      <input type="text" placeholder="Tìm Kiếm Sách..." />
    </form>
    <div class="header-icons">
      <a href="<%= request.getContextPath() %>/cart.jsp" class="fas fa-shopping-cart"></a>
      <a href="#" id="mobile-login-btn" class="fas fa-user"></a>
    </div>
  </div>
</header>

<div id="mobile-sidebar" class="mobile-sidebar">
  <div class="sidebar-header">
    <span id="close-sidebar" class="fas fa-arrow-left"></span>
    <span class="sidebar-title">Danh Mục Sản Phẩm</span>
  </div>
  <ul class="sidebar-menu">
    <li>
      <a href="<%= request.getContextPath() %>/books.jsp"><b>Tất Cả Sản Phẩm</b></a>
    </li>
    <li class="has-submenu">
      <a href="#" class="submenu-toggle">
        <b>Thể Loại</b>
        <span class="fas fa-chevron-down" style="float: right"></span>
      </a>
      <ul class="submenu">
        <li><a href="#">Văn Học</a></li>
        <li><a href="#">Kinh Tế</a></li>
        <li><a href="#">Tâm Lý - Kỹ Năng Sống</a></li>
        <li><a href="#">Thiếu Nhi</a></li>
        <li><a href="#">Giáo Khoa - Tham Khảo</a></li>
      </ul>
    </li>
  </ul>
</div>
<div id="sidebar-overlay" class="sidebar-overlay"></div>
<!-- bottom navbar start-->

<!-- login form start-->
<div class="login-form-container">
  <div id="close-login-btn" class="fas fa-times"></div>

  <!-- Login Form -->
  <form id="login-form" method="post" action="<%= request.getContextPath() %>/login">
    <h3>Đăng nhập</h3>
    <span>Email</span>
    <input type="email" class="box" name="email" placeholder="Nhập email của bạn" required />
    <span>Mật khẩu</span>
    <input type="password" class="box" name="password" placeholder="Nhập mật khẩu" required />
    <div class="checkbox">
      <input type="checkbox" id="remember-me" name="remember" />
      <label for="remember-me"> Ghi nhớ đăng nhập</label>
    </div>
    <input type="submit" value="Đăng nhập" class="btn" />
    <p><a href="#">Quên mật khẩu?</a></p>
    <p><a href="javascript:void(0)" onclick="showForm('register')">Chưa có tài khoản?</a></p>
  </form>

  <!-- Register Form -->
  <form id="register-form" method="post" action="<%= request.getContextPath() %>/register" style="display: none;" onsubmit="return validateRegisterForm()">
    <h3>Đăng ký</h3>
    <span>Tên</span>
    <input type="text" class="box" id="register-ten" name="ten" placeholder="Nhập tên của bạn" required />

    <span>Email</span>
    <input type="email" class="box" id="register-email" name="email" placeholder="Nhập email" required />

    <span>Mật khẩu</span>
    <input type="password" class="box" id="register-matkhau" name="mat_khau" placeholder="Nhập mật khẩu" required />

    <span>Xác nhận mật khẩu</span>
    <input type="password" class="box" id="register-xacnhan" name="xac_nhan_mat_khau" placeholder="Xác nhận mật khẩu" required />

    <input type="submit" value="Đăng ký" class="btn" />
    <p><a href="javascript:void(0)" onclick="showForm('login')">Đã có tài khoản?</a></p>
  </form>

</div>


<!-- login form end-->
<script>
  function showForm(formType) {
    document.getElementById('login-form').style.display = formType === 'login' ? 'block' : 'none';
    document.getElementById('register-form').style.display = formType === 'register' ? 'block' : 'none';

    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
    document.querySelector(`.tab-btn[onclick*="${formType}"]`).classList.add('active');
  }
  function validateRegisterForm() {
    const ten = document.getElementById('register-ten').value.trim();
    const email = document.getElementById('register-email').value.trim();
    const matkhau = document.getElementById('register-matkhau').value;
    const xacnhan = document.getElementById('register-xacnhan').value;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (ten === '' || email === '' || matkhau === '' || xacnhan === '') {
      toastr.error('Vui lòng điền đầy đủ tất cả các trường');
      return false;
    }

    if (!emailRegex.test(email)) {
      toastr.error('Email không hợp lệ');
      return false;
    }

    if (matkhau.length < 6) {
      toastr.error('Mật khẩu phải có ít nhất 6 ký tự');
      return false;
    }

    if (matkhau !== xacnhan) {
      toastr.error('Mật khẩu và xác nhận mật khẩu không khớp');
      return false;
    }

    return true; // cho phép submit
  }
</script>

<%
  Boolean registerSuccess = (Boolean) session.getAttribute("registerSuccess");
  String registerError = (String) session.getAttribute("registerError");
  session.removeAttribute("registerSuccess");
  session.removeAttribute("registerError");
%>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const loginFormContainer = document.querySelector(".login-form-container");
    const loginForm = document.getElementById("login-form");
    const registerForm = document.getElementById("register-form");

    <% if (user != null) { %>
    // User is logged in, hide login and register forms
    loginFormContainer.style.display = "none";
    <% } else { %>
    // User not logged in
    // Nếu đăng ký thành công thì mở form login + show toast
    <% if (registerSuccess != null && registerSuccess) { %>
    toastr.success('Đăng ký thành công! Vui lòng đăng nhập.');
    loginFormContainer.classList.add("active");
    loginForm.style.display = "block";
    registerForm.style.display = "none";
    <% } else { %>
    // Lần đầu mở web không auto mở form login
    loginFormContainer.classList.remove("active");
    <% } %>
    <% } %>

    // Close login form when clicking the close button
    document.getElementById("close-login-btn").addEventListener("click", function () {
      loginFormContainer.classList.remove("active");
    });
  });
</script>

</body>
</html>