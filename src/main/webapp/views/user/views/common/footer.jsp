<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/30/2025
  Time: 8:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            src="https://nhasachphuongnam.com/images/promo/126/bo-cong-thuong-130x87_new1.png"
            alt="Đã thông báo Bộ Công Thương"
            style="height: 65px; margin-right: 5px"
    />
    <img
            src="https://nhasachphuongnam.com/images/promo/126/Untitled-1.png"
            alt="Chứng nhận"
            style="height: 65px"
    />
  </div>
</section>
<!-- footer section end -->
</body>
</html>