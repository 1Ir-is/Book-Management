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
</head>
<body>
<!-- header section start -->

<header class="header">
  <!-- header 1 -->
  <div class="header-1">
    <a href="<%= request.getContextPath() %>/home" class="logo"><i class="fas fa-book"></i> 4Book</a>

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

  <form method="post" action="<%= request.getContextPath() %>/login">
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
    <p><a href="<%= request.getContextPath() %>/register">Chưa có tài khoản?</a></p>
  </form>
</div>

<!-- login form end-->

<!-- home section start -->
<section class="home" id="home">
  <div class="row">
    <div class="content">
      <h3>Giảm giá đến 75%</h3>
      <p>
        Khám phá kho tàng sách hấp dẫn với ưu đãi siêu khủng! Nhiều đầu sách
        nổi bật, từ tiểu thuyết, kỹ năng sống đến sách học tập đang chờ bạn
        với mức giá ưu đãi chưa từng có. Mua ngay hôm nay!
      </p>
      <a href="#" class="btn">Mua ngay</a>
    </div>

    <div class="books-slider">
      <img src="<%= request.getContextPath() %>/assets/image/table.png" class="stand" alt="Giá sách nổi bật" />
    </div>
  </div>
</section>

<!-- home section end -->

<!-- service section start -->
<section class="icons-container">
  <div class="icons">
    <i class="fas fa-plane"></i>
    <div class="content">
      <h3>Miễn phí vận chuyển</h3>
      <p>Đơn hàng từ 2.500.000đ</p>
    </div>
  </div>

  <div class="icons">
    <i class="fas fa-lock"></i>
    <div class="content">
      <h3>Thanh toán an toàn</h3>
      <p>Bảo mật 100%</p>
    </div>
  </div>

  <div class="icons">
    <i class="fas fa-redo-alt"></i>
    <div class="content">
      <h3>Đổi trả dễ dàng</h3>
      <p>Trong vòng 10 ngày</p>
    </div>
  </div>

  <div class="icons">
    <i class="fas fa-headset"></i>
    <div class="content">
      <h3>Hỗ trợ 24/7</h3>
      <p>Gọi cho chúng tôi bất cứ lúc nào</p>
    </div>
  </div>
</section>
<!-- service section end -->

<!-- footer section start -->
<section class="footer">
  <div class="box-container">
    <div class="box">
      <h3>Địa chỉ của chúng tôi</h3>
      <a href="#"><i class="fas fa-map-marker-alt"></i> Việt Nam </a>
      <a href="#"><i class="fas fa-map-marker-alt"></i> Nhật Bản </a>
      <a href="#"><i class="fas fa-map-marker-alt"></i> Hàn Quốc </a>
      <a href="#"><i class="fas fa-map-marker-alt"></i> Hoa Kỳ </a>
      <a href="#"><i class="fas fa-map-marker-alt"></i> Ấn Độ </a>
      <a href="#"><i class="fas fa-map-marker-alt"></i> Pháp </a>
    </div>

    <div class="box">
      <h3>Liên kết nhanh</h3>
      <a href="#"><i class="fas fa-arrow-right"></i> Trang chủ </a>
      <a href="#"><i class="fas fa-arrow-right"></i> Nổi bật </a>
      <a href="#"><i class="fas fa-arrow-right"></i> Sách mới </a>
      <a href="#"><i class="fas fa-arrow-right"></i> Đánh giá </a>
      <a href="#"><i class="fas fa-arrow-right"></i> Blog </a>
    </div>

    <div class="box">
      <h3>Liên kết khác</h3>
      <a href="#"
      ><i class="fas fa-arrow-right"></i> Thông tin tài khoản
      </a>
      <a href="#"><i class="fas fa-arrow-right"></i> Đơn hàng đã đặt </a>
      <a href="#"><i class="fas fa-arrow-right"></i> Chính sách bảo mật </a>
      <a href="#"
      ><i class="fas fa-arrow-right"></i> Phương thức thanh toán
      </a>
      <a href="#"
      ><i class="fas fa-arrow-right"></i> Dịch vụ của chúng tôi
      </a>
    </div>

    <div class="box">
      <h3>Thông tin liên hệ</h3>
      <a href="#"><i class="fas fa-phone"></i> +123-456-7890 </a>
      <a href="#"><i class="fas fa-phone"></i> +111-222-3333 </a>
      <a href="#"><i class="fas fa-envelope"></i> 4bookstore@gmail.com </a>
      <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3833.751890135277!2d108.20973629999999!3d16.078359799999998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314219a486b7f699%3A0xae6269b629a63e82!2zQ29kZUd5bSDEkMOgIE7hurVuZw!5e0!3m2!1svi!2s!4v1748497453775!5m2!1svi!2s"
              width="100%"
              height="220"
              style="border: 0; border-radius: 8px; margin-top: 10px"
              allowfullscreen=""
              loading="lazy"
              referrerpolicy="no-referrer-when-downgrade"
              title="Bản đồ CodeGym Đà Nẵng"
      ></iframe>
    </div>
  </div>
  <div class="share">
    <a href="#" class="fab fa-facebook-f"></a>
    <a href="#" class="fab fa-twitter"></a>
    <a href="#" class="fab fa-instagram"></a>
    <a href="#" class="fab fa-linkedin"></a>
    <a href="#" class="fab fa-github"></a>
  </div>

  <div class="credit">
    Được tạo ra bởi <span> 4B Corporation</span> | Đã đăng ký bản quyền
  </div>
  <div class="gov-cert">
    <img
            src="<%= request.getContextPath() %>/assets/image/bo-cong-thuong.png"
            alt="Đã thông báo Bộ Công Thương"
            style="height: 65px; margin-right: 5px"
    />
    <img
            src="<%= request.getContextPath() %>/assets/image/chung-nhan.png"
            alt="Chứng nhận"
            style="height: 65px"
    />
  </div>
</section>
<!-- footer section end -->

<!-- Popup Overlay -->
<div id="popup-overlay">
  <div class="popup-content">
    <span id="close-popup">&times;</span>
    <h2>📚 Tham Gia Cộng Đồng Độc Giả 4B</h2>
    <p>
      Cùng hàng ngàn người yêu sách khám phá thế giới tri thức, chia sẻ cảm
      nhận và cập nhật những đầu sách hay mỗi tuần!
    </p>
    <p>
      Đăng ký ngay để nhận <strong>tài liệu, ưu đãi độc quyền</strong> và
      những món quà bất ngờ từ 4B Books.
    </p>
    <a href="<%= request.getContextPath() %>/register" class="btn">Tham Gia Ngay</a>
  </div>
</div>

<!-- Custom JS file link -->
<script>
  const sidebar = document.getElementById("mobile-sidebar");
  const overlay = document.getElementById("sidebar-overlay");
  const openBtn = document.querySelector(".header-icon-left");
  const closeBtn = document.getElementById("close-sidebar");
  const mobileLoginBtn = document.querySelector("#mobile-login-btn");
  document.addEventListener("DOMContentLoaded", function () {
    var btn = document.getElementById("featured-btn");
    var dropdown = document.querySelector(".bottom-dropdown");
    btn.addEventListener("click", function (e) {
      e.preventDefault();
      dropdown.classList.toggle("open");
    });
    document.addEventListener("click", function (e) {
      if (!dropdown.contains(e.target)) {
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
      loginForm.classList.toggle("active");
    };
  }

  document.addEventListener("DOMContentLoaded", function () {
    const loginBtn = document.getElementById("login-btn");
    const loginForm = document.querySelector(".login-form-container");

    if (loginBtn && loginForm) {
      loginBtn.addEventListener("click", function () {
        loginForm.classList.add("active");
      });
    }
  });
</script>
<script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/script.js"></script>
</body>
</html>