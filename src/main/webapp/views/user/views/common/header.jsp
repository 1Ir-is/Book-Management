<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>4Book - Nhà sách trực tuyến</title>

  <!-- Icon -->
  <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/image/book-shop.png" />

  <!-- Font awesome cdn link -->
  <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />

  <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />

  <!-- Custom Css file link-->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />

  <!-- Toastr Notifications -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
  <style>
    .icons {
      display: flex;
      align-items: center;
      gap: 28px;
    }

    .icons > * {
      margin-left: 0 !important;
    }
    .modal {
      display: none;
      position: fixed !important;
      z-index: 9999;
      inset: 0;
      width: 100vw;
      height: 100vh;
      background: rgba(30, 41, 59, 0.45);
      justify-content: center;
      align-items: center;
      transition: background 0.2s ease;
    }

    .modal-content {
      background: #ffffff;
      padding: 24px 20px;
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
      text-align: center;
      width: 90%;
      max-width: 380px;
      animation: modalFadeIn 0.25s ease;
    }

    .cart-count {
      position: absolute;
      top: -8px;
      right: -8px;
      background: red;
      color: white;
      border-radius: 50%;
      font-size: 12px;
      padding: 2px 6px;
    }


    @keyframes modalFadeIn {
      from {
        transform: translateY(20px) scale(0.95);
        opacity: 0;
      }
      to {
        transform: translateY(0) scale(1);
        opacity: 1;
      }
    }

    @media (max-width: 480px) {
      #blocked-account-modal > div {
        width:98vw !important;max-width:98vw !important;
        padding:18px 7px 14px 7px !important;border-radius:14px !important;
      }
      #blocked-account-modal i {
        font-size:3.2rem !important;margin-bottom:0.7rem !important;
      }
      #blocked-account-modal h2 {
        font-size:1.3rem !important;margin-bottom:0.5rem !important;
      }
      #blocked-account-modal p {
        font-size:1.05rem !important;margin-bottom:1rem !important;
      }
      #blocked-account-modal button {
        font-size:1.05rem !important;padding:0.7rem 0 !important;border-radius:8px !important;
      }
    }
    .modal-icon {
      font-size: 4.5rem;
      color: #27ae60;
      margin-bottom: 1rem;
    }

    .modal-content h3 {
      font-size: 2rem;
      font-weight: 700;
      color: #2c3e50;
      margin-bottom: 0.5rem;
    }

    .modal-content p {
      font-size: 1.7rem;
      color: #555;
      margin-bottom: 1.5rem;
    }

    .modal-actions {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .modal-actions .btn {
      padding: 0.75rem;
      font-size: 1.4rem;
      font-weight: 600;
      border: none;
      border-radius: 12px;
      cursor: pointer;
      transition: background 0.2s ease, box-shadow 0.2s ease;
    }

    #confirm-logout {
      background: #27ae60;
      color: #fff;
      box-shadow: 0 4px 12px rgba(39, 174, 96, 0.2);
    }

    #confirm-logout:hover {
      background: #219150;
    }

    #cancel-logout {
      background: #f2f2f2;
      color: #2d3436;
      border: 1px solid #dfe6e9;
    }

    #cancel-logout:hover {
      background: #e0e0e0;
    }

    .search-form button {
      background: transparent !important;
      border: none !important;
      box-shadow: none !important;
      padding: 0 !important;
    }
    .search-form button:focus {
      outline: none !important;
    }
    .search-form .fa-search {
      background: none !important;
      color: #333; /* hoặc màu bạn muốn */
      font-size: 1.2rem;
      padding: 0;
    }



    /* Đặt ở cuối file <style> hoặc sau phần modal */
    @media (max-width: 480px) {
      .modal-content {
        width: 96vw;
        max-width: 320px;
        min-width: unset;
        padding: 20px 16px;
        border-radius: 18px;
        margin: 0 auto;
      }
      .modal-icon {
        font-size: 3rem;
        margin-bottom: 0.7rem;
      }
      .modal-content h3 {
        font-size: 2rem;
        margin-bottom: 0.3rem;
      }
      .modal-content p {
        font-size: 1.5rem;
        margin-bottom: 1.1rem;
      }
      .modal-actions .btn {
        font-size: 1.7rem;
        padding: 0.7rem 0.2rem;
        border-radius: 10px;
      }
    }


    @media only screen and (max-width: 768px) {
      .mobile-search-form {
        display: flex;
        align-items: center;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 8px #0001;
        padding: 0.2rem 0.7rem;
        width: 100%;
        max-width: 400px;
        margin: 0 auto;
      }

      .mobile-search-form input[type="text"] {
        flex: 1;
        border: none;
        outline: none;
        padding: 0.7rem 0.8rem;
        font-size: 1.1rem;
        border-radius: 8px;
        background: transparent;
      }

      .mobile-search-form button {
        background: none;
        border: none;
        outline: none;
        padding: 0 0.3rem;
        display: flex;
        align-items: center;
        cursor: pointer;
      }

      .mobile-search-form .fa-search {
        font-size: 1.5rem;
        color: #222;
        background: none;
        margin-left: 0.2rem;
      }
      #toast-container > div {
        font-size: 14px !important;
        padding: 10px 14px !important;
        width: 90% !important;
        margin: 8px auto !important;
      }

      #toast-container {
        top: 10px !important;
        right: 5% !important;
        left: 5% !important;
      }
    }
  </style>
</head>

<body>
<!-- header section start -->

<header class="header">
  <!-- header 1 -->
  <div class="header-1">
    <a href="${pageContext.request.contextPath}/" class="logo">
      <i class="fas fa-book"></i> 4Book
    </a>

    <form method="get" action="${pageContext.request.contextPath}/books" class="search-form">
      <input type="text" name="keyword" placeholder="Tìm kiếm ..." value="${param.keyword}" id="search-box" />
      <button type="submit">
        <label for="search-box" class="fas fa-search" style="cursor: pointer;"></label>
      </button>
    </form>


    <div class="icons">
      <div id="search-btn" class="fas fa-search"></div>
      <a href="#" class="fas fa-heart"></a>
        <a href="<%= request.getContextPath() %>/user/cart" id="cart-icon" class="fas fa-shopping-cart" style="position: relative;">
          <span id="cart-count" class="cart-count">
            <c:choose>
              <c:when test="${not empty cartCount}">
                ${cartCount}
              </c:when>
              <c:otherwise>0</c:otherwise>
            </c:choose>
          </span>
        </a>



      <div class="dropdown">
        <c:if test="${user != null}">
          <!-- Đã đăng nhập -->
          <c:choose>
            <c:when test="${not empty user.avatarUrl}">
              <img src="${user.avatarUrl}" alt="Avatar" class="dropbtn"
                   style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover;" />
            </c:when>
            <c:otherwise>
              <div class="fas fa-user dropbtn"></div>
            </c:otherwise>
          </c:choose>
          <div class="dropdown-content" style="padding: 8px 0; min-width: 180px;">
            <div class="drop-content"
                 style="font-weight: 600; font-size: 14px; padding: 6px 14px; cursor: default; line-height: 1.4;">
              Xin chào,<br />
                ${user.name}
            </div>
            <div style="height: 1px; background-color: #e0e0e0; margin: 6px 0;"></div>
            <a class="drop-content" href="${pageContext.request.contextPath}/profile"
               style="padding: 6px 14px; display: block; text-decoration: none; color: #333; font-size: 13px;">
              Thông tin
            </a>
            <a class="drop-content" href="${pageContext.request.contextPath}/history.jsp"
               style="padding: 6px 14px; display: block; text-decoration: none; color: #333; font-size: 13px;">
              Lịch sử mua hàng
            </a>
            <c:if test="${user != null}">
              <a href="javascript:void(0)" id="logout-link" class="drop-content"
                 style="padding: 6px 14px; display: block; text-decoration: none; color: #333; font-size: 13px;">
                Đăng xuất
              </a>
            </c:if>
          </div>
        </c:if>
        <c:if test="${user == null}">
          <!-- Chưa đăng nhập -->
          <div id="login-btn" class="fas fa-user dropbtn"></div>
        </c:if>
      </div>
    </div>
  </div>

  <!-- header 2 -->
  <div class="header-2">
    <nav class="navbar">
      <a class="dropbtn" href="${pageContext.request.contextPath}/books">Khám phá sách hay</a>
      <div class="dropdown">
        <a class="dropbtn" href="#Category">Thể loại</a>
        <div class="dropdown-content">
          <c:forEach items="${categories}" var="category">
            <a class="drop-content"
               href="${pageContext.request.contextPath}/books?category=${category.categoryId}">
                ${category.categoryName}
            </a>
          </c:forEach>
        </div>
      </div>
      <a class="dropbtn" href="#reviews">Đánh giá</a>
      <a class="dropbtn" href="#blogs">Blog</a>
    </nav>
  </div>
</header>

<header class="mobile-header">
  <a href="${pageContext.request.contextPath}/">
    <div class="mobile-header-logo" style="text-align: center; padding-top: 1rem">
      <img src="${pageContext.request.contextPath}/assets/image/book-shop.png" alt="4Book Logo" style="height: 38px" />
    </div>
  </a>
  <div class="mobile-header-bar">
    <a href="#" class="header-icon-left fas fa-list"></a>
    <form method="get" action="${pageContext.request.contextPath}/books" class="mobile-search-form">
      <input type="text" name="keyword" placeholder="Tìm Kiếm Sách..." value="${param.keyword}" id="mobile-search-box" />
      <button type="submit">
        <i class="fas fa-search"></i>
      </button>
    </form>
    <div class="header-icons">
      <a href="${pageContext.request.contextPath}/cart.jsp" class="fas fa-shopping-cart"></a>
      <c:if test="${user != null}">
        <c:choose>
          <c:when test="${not empty user.avatarUrl}">
            <img src="${user.avatarUrl}" alt="Avatar" id="mobile-avatar" style="width: 32px; height: 32px; border-radius: 50%; object-fit: cover; cursor: pointer;" />
          </c:when>
          <c:otherwise>
            <a href="#" id="mobile-login-btn" class="fas fa-user"></a>
          </c:otherwise>
        </c:choose>
      </c:if>
      <c:if test="${user == null}">
        <a href="#" id="mobile-login-btn" class="fas fa-user"></a>
      </c:if>
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
      <a href="${pageContext.request.contextPath}/books"><b>Tất Cả Sản Phẩm</b></a>
    </li>
    <li class="has-submenu">
      <a href="#" class="submenu-toggle">
        <b>Thể Loại</b>
        <span class="fas fa-chevron-down" style="float: right"></span>
      </a>
      <ul class="submenu">
        <c:forEach items="${categories}" var="category">
          <li>
            <a href="${pageContext.request.contextPath}/books?category=${category.categoryId}">
                ${category.categoryName}
            </a>
          </li>
        </c:forEach>
      </ul>
    </li>

    <c:if test="${user != null}">
      <li>
        <a href="${pageContext.request.contextPath}/profile"><b>Thông Tin Cá Nhân</b></a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/history.jsp"><b>Lịch Sử Mua Hàng</b></a>
      </li>
      <c:if test="${user != null}">
        <li>
          <a href="javascript:void(0)" id="mobile-logout-link"><b>Đăng Xuất</b></a>
        </li>
      </c:if>
    </c:if>
    <c:if test="${user == null}">
      <li>
        <a href="javascript:void(0)" onclick="showForm('login'); loginFormContainer.classList.add('active');"><b>Đăng Nhập</b></a>
      </li>
    </c:if>
  </ul>
</div>
<div id="sidebar-overlay" class="sidebar-overlay"></div>
<!-- bottom navbar end -->

<!-- login form start -->
<div class="login-form-container">
  <div id="close-login-btn" class="fas fa-times"></div>

  <!-- Login Form -->
  <form id="login-form" method="post" action="${pageContext.request.contextPath}/login">
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
  <form id="register-form" method="post" action="${pageContext.request.contextPath}/register" style="display: none;" onsubmit="return validateRegisterForm()">
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
<!-- login form end -->

<!-- MODAL XÁC NHẬN ĐĂNG XUẤT - DÙNG CHUNG CHO DESKTOP VÀ MOBILE -->
<c:if test="${user != null}">
  <div id="logout-modal" class="modal">
    <div class="modal-content">
      <div class="modal-icon">
        <i class="fa-solid fa-circle-question"></i>
      </div>
      <h3>Xác nhận</h3>
      <p>Bạn có chắc chắn muốn đăng xuất không?</p>
      <div class="modal-actions">
        <button id="confirm-logout" class="btn">Đăng xuất</button>
        <button id="cancel-logout" class="btn">Hủy</button>
      </div>
    </div>
  </div>
</c:if>

<c:if test="${not empty accountBlocked}">
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const modal = document.getElementById("blocked-account-modal");
      modal.style.display = "flex";
    });
    function closeModal() {
      document.getElementById("blocked-account-modal").style.display = "none";
    }
  </script>
  <div id="blocked-account-modal" style="
    display:none;position:fixed;z-index:9999;inset:0;width:100vw;height:100vh;
    background:rgba(30,41,59,0.45);justify-content:center;align-items:center;">
    <div style="
      background:#fff;padding:32px 28px 28px 28px;border-radius:22px;
      box-shadow:0 8px 24px rgba(0,0,0,0.15);text-align:center;width:92vw;
      max-width:420px;animation:modalFadeIn 0.25s ease;position:relative;">
      <div style="font-size:5rem;color:#e74c3c;margin-bottom:1.2rem;">
        <i class='bx bxs-lock-alt'></i>
      </div>
      <h2 style="
        font-size:2rem;
        font-weight:800;
        color:#2c3e50;
        margin-bottom:1rem;
        margin-top:0;
        letter-spacing:0.5px;
      ">
        Tài Khoản Bị Khóa
      </h2>
      <p style="
  font-size:1.25rem;
  color:#444;
  margin-bottom:1.5rem;
  line-height:1.6;
  font-weight:500;
">
        Tài Khoản Của Bạn Đã Bị Khóa.<br>
        Thông Tin Chi Tiết Vui Lòng Liên Hệ Đến
        <a href="${pageContext.request.contextPath}/contact-admin" style="color:#3498db; text-decoration:underline; font-weight:bold;">
          Admin
        </a>.
      </p>
      <button onclick="closeModal()" style="
        background:#27ae60;color:#fff;font-size:1.2rem;font-weight:700;
        border:none;border-radius:12px;padding:0.9rem 0;width:100%;cursor:pointer;
        transition:background 0.2s;box-shadow:0 4px 12px rgba(39,174,96,0.13);">
        Đóng
      </button>
    </div>
  </div>
</c:if>

<script>
  const sidebar = document.getElementById("mobile-sidebar");
  const overlay = document.getElementById("sidebar-overlay");
  const openBtn = document.querySelector(".header-icon-left");
  const closeBtn = document.getElementById("close-sidebar");
  const mobileLoginBtn = document.querySelector("#mobile-login-btn");

  document.addEventListener("DOMContentLoaded", function () {
    const btn = document.getElementById("featured-btn");
    const dropdown = document.querySelector(".bottom-dropdown");
    if (btn) {
      btn.addEventListener("click", function (e) {
        e.preventDefault();
        dropdown.classList.toggle("open");
      });
    }
    document.addEventListener("click", function (e) {
      if (dropdown && !dropdown.contains(e.target)) {
        dropdown.classList.remove("open");
      }
    });
  });

  openBtn.addEventListener("click", function (e) {
    e.preventDefault();
    sidebar.classList.add("open");
    overlay.classList.add("show");
  });
  closeBtn.addEventListener("click", function () {
    sidebar.classList.remove("open");
    overlay.classList.remove("show");
  });
  overlay.addEventListener("click", function () {
    sidebar.classList.remove("open");
    overlay.classList.remove("show");
  });
  document.querySelectorAll(".submenu-toggle").forEach(function (toggle) {
    toggle.addEventListener("click", function (e) {
      e.preventDefault();
      const parent = this.closest(".has-submenu");
      parent.classList.toggle("open");
    });
  });

  if (mobileLoginBtn) {
    mobileLoginBtn.onclick = () => {
      const isLoggedIn = ${user != null}; // Pass the boolean value directly
      if (!isLoggedIn) {
        document.querySelector(".login-form-container").classList.toggle("active");
      } else {
        toastr.info("Bạn đã đăng nhập.");
      }
    };
  }

  document.addEventListener("DOMContentLoaded", function () {
    const errorText = "${requestScope.error != null ? requestScope.error : ''}";
    if (errorText.trim() !== "") {
      document.querySelector(".login-form-container").classList.add("active");
      toastr.error(errorText);
    }
  });

  document.addEventListener("DOMContentLoaded", function () {
    const mobileLogoutLink = document.getElementById("mobile-logout-link");
    const logoutLink = document.getElementById("logout-link"); // Thêm dòng này
    const logoutModal = document.getElementById("logout-modal");
    const confirmLogout = document.getElementById("confirm-logout");
    const cancelLogout = document.getElementById("cancel-logout");

    // Mobile logout
    if (mobileLogoutLink) {
      mobileLogoutLink.addEventListener("click", function () {
        logoutModal.style.display = "flex";
      });
    }

    // ✅ Desktop logout
    if (logoutLink) {
      logoutLink.addEventListener("click", function () {
        logoutModal.style.display = "flex";
      });
    }

    if (confirmLogout) {
      confirmLogout.addEventListener("click", function () {
        window.location.href = "${pageContext.request.contextPath}/logout";
      });
    }

    if (cancelLogout) {
      cancelLogout.addEventListener("click", function () {
        logoutModal.style.display = "none";
      });
    }

    window.addEventListener("click", function (e) {
      if (e.target === logoutModal) {
        logoutModal.style.display = "none";
      }
    });
  });


</script>

<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

<c:if test="${not empty sessionScope.success}">
  <script>
    $(document).ready(function() {
      toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "300",
        "timeOut": "3000",
        "extendedTimeOut": "500",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
      };
      toastr.success("${fn:escapeXml(sessionScope.success)}");
    });
  </script>
  <c:remove var="success" scope="session" />
</c:if>

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

    return true;
  }

  document.getElementById("cart-icon").addEventListener("click", function (e) {
    e.preventDefault();
    <c:choose>
    <c:when test="${empty user}">
    toastr.warning("Bạn cần đăng nhập để xem giỏ hàng!");
    document.querySelector(".login-form-container").classList.add("active");
    document.getElementById("login-form").style.display = "block";
    document.getElementById("register-form").style.display = "none";
    </c:when>
    <c:otherwise>
    window.location.href = "<%= request.getContextPath() %>/user/cart";
    </c:otherwise>
    </c:choose>
  });
</script>

<c:if test="${not empty sessionScope.registerSuccess}">
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      toastr.success('Đăng ký thành công! Vui lòng đăng nhập.');
      const loginFormContainer = document.querySelector(".login-form-container");
      loginFormContainer.classList.add("active");
      document.getElementById("login-form").style.display = "block";
      document.getElementById("register-form").style.display = "none";
    });
  </script>
  <c:remove var="registerSuccess" scope="session" />
</c:if>

</body>
</html>
