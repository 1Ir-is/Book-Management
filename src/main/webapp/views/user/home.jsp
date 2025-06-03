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

  <!-- Toastr Notifications -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>

<body>
<!-- header section start -->
<jsp:include page="views/common/header.jsp" />
<!-- header section end -->

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

<!-- featured section start -->
<section class="featured" id="featured">
  <h1 class="heading"><span>Sách Nổi Bật</span></h1>

  <div class="featured-grid">
    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/book_1.jpg" alt="" />
      </div>
      <div class="content">
        <h3>Sách Nổi Bật</h3>
        <div class="price">369.000đ</div>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/book_1.jpg" alt="" />
      </div>
      <div class="content">
        <h3>Sách Nổi Bật</h3>
        <div class="price">369.000đ</div>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/book_1.jpg" alt="" />
      </div>
      <div class="content">
        <h3>Sách Nổi Bật</h3>
        <div class="price">369.000đ</div>
      </div>
    </div>
  </div>
</section>

<!-- featured section end -->

<!-- arrivals section start -->
<section class="arrivals" id="arrivals">
  <h1 class="heading"><span>Sách Mới Về</span></h1>

  <div class="arrivals-grid">
    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/book_11.jpg" alt="" />
      </div>
      <div class="content">
        <h3>Sách Mới Về</h3>
        <div class="price">369.000đ</div>
        <div class="stars">
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star-half-alt"></i>
        </div>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/book_12.png" alt="" />
      </div>
      <div class="content">
        <h3>Sách Mới Về</h3>
        <div class="price">369.000đ</div>
        <div class="stars">
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star-half-alt"></i>
        </div>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/book_13.png" alt="" />
      </div>
      <div class="content">
        <h3>Sách Mới Về</h3>
        <div class="price">369.000đ</div>
        <div class="stars">
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star"></i>
          <i class="fas fa-star-half-alt"></i>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- arrivals section end -->

<!-- deal section start -->
<section class="deal">
  <div class="content">
    <h3>Ưu đãi trong ngày</h3>
    <h1>Giảm giá đến 50%</h1>
    <p>
      Đừng bỏ lỡ cơ hội sở hữu những cuốn sách yêu thích với mức giá cực
      sốc! Ưu đãi chỉ áp dụng trong hôm nay cho các đầu sách nổi bật, số
      lượng có hạn. Nhanh tay chọn mua ngay để nhận thêm nhiều phần quà hấp
      dẫn từ 4Book Store!
    </p>
    <a href="#" class="btn">Mua ngay</a>
  </div>

  <div class="image">
    <img src="<%= request.getContextPath() %>/assets/image/about.png" alt="Ưu đãi trong ngày" />
  </div>
</section>
<!-- deal section end -->

<!-- review section start -->
<section class="reviews" id="reviews">
  <h1 class="heading"><span>Đánh Giá</span></h1>

  <div class="reviews-grid">
    <div class="box">
      <img
              src="<%= request.getContextPath() %>/assets/image/duy.jpg"
              alt="Ảnh người dùng 1"
      />
      <h3>Tôn Thất Duy</h3>
      <p>
        Sách giao nhanh, đóng gói cẩn thận. Nội dung rất hay và bổ ích, sẽ
        tiếp tục ủng hộ shop!
      </p>
      <div class="stars">
        <i class="fas fa-star"></i><i class="fas fa-star"></i
      ><i class="fas fa-star"></i><i class="fas fa-star"></i
      ><i class="fas fa-star-half-alt"></i>
      </div>
    </div>

    <div class="box">
      <img
              src="<%= request.getContextPath() %>/assets/image/huy.jpg"
              alt="Ảnh người dùng 2"
      />
      <h3>Huỳnh Minh Huy</h3>
      <p>
        Shop tư vấn nhiệt tình, sách mới nguyên, giá tốt. Rất hài lòng với
        dịch vụ!
      </p>
      <div class="stars">
        <i class="fas fa-star"></i><i class="fas fa-star"></i
      ><i class="fas fa-star"></i><i class="fas fa-star"></i
      ><i class="fas fa-star-half-alt"></i>
      </div>
    </div>

    <div class="box">
      <img
              src="<%= request.getContextPath() %>/assets/image/vuong.jpg"
              alt="Ảnh người dùng 3"
      />
      <h3>Phan Tá Anh Vương</h3>
      <p>
        Đa dạng đầu sách, chất lượng in tốt. Mình đã giới thiệu cho bạn bè
        cùng mua.
      </p>
      <div class="stars">
        <i class="fas fa-star"></i><i class="fas fa-star"></i
      ><i class="fas fa-star"></i><i class="fas fa-star"></i
      ><i class="fas fa-star-half-alt"></i>
      </div>
    </div>
  </div>
</section>

<!-- review section end -->

<!-- blog section start -->
<section class="blogs" id="blogs">
  <h1 class="heading"><span>Blog</span></h1>

  <div class="blogs-grid">
    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/blog_1.jpg" alt="Blog 1" />
      </div>
      <div class="content">
        <h3>Cách chọn một cuốn sách hay</h3>
        <p>
          Khám phá bí quyết lựa chọn sách phù hợp với sở thích và mục tiêu
          của bạn. Đừng bỏ lỡ những gợi ý hữu ích từ chuyên gia!
        </p>
        <a href="#" class="btn">Đọc thêm</a>
      </div>
    </div>

    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/blog_2.jpg" alt="Blog 2" />
      </div>
      <div class="content">
        <h3>Top 10 tiểu thuyết nên đọc</h3>
        <p>
          Danh sách những cuốn tiểu thuyết nổi bật, được yêu thích nhất mọi
          thời đại mà bạn không nên bỏ qua.
        </p>
        <a href="#" class="btn">Đọc thêm</a>
      </div>
    </div>

    <div class="box">
      <div class="image">
        <img src="<%= request.getContextPath() %>/assets/image/blog_3.jpg" alt="Blog 3" />
      </div>
      <div class="content">
        <h3>Lợi ích của việc đọc sách mỗi ngày</h3>
        <p>
          Đọc sách mỗi ngày giúp phát triển tư duy, mở rộng kiến thức và cải
          thiện kỹ năng sống của bạn như thế nào?
        </p>
        <a href="#" class="btn">Đọc thêm</a>
      </div>
    </div>
  </div>
</section>
<!-- blog section end -->

<!-- footer section start -->
<jsp:include page="views/common/footer.jsp" />
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
</body>
</html>