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
              src="https://scontent.fsgn2-4.fna.fbcdn.net/v/t39.30808-6/433010090_1874555349648586_4650447987992120796_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeEr0XJfh5_BvQYnHfmsbuoRpfQGyIgh3Bql9AbIiCHcGrPUpJkjBLqXKiR8g1ZrqkwcNLOUweUnTkQ0_aTMlZr0&_nc_ohc=9UW9zyudsUAQ7kNvwG_yk6p&_nc_oc=AdlWtYeCJmuCSGjYN7e7LYIwKPNN5jnq3vhJ5a5DtgfXD7QRUvvSFV7B-cAiPfGbY6Y&_nc_zt=23&_nc_ht=scontent.fsgn2-4.fna&_nc_gid=28VdL7yM3uz3aHDmXw64Tg&oh=00_AfLv4QWQyvqa6c-7L-40lBVKlgmK7CMNBNzhxsncRNlKgA&oe=683DB608"
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
              src="https://scontent.fsgn2-9.fna.fbcdn.net/v/t39.30808-1/416373411_1426075498255549_6395391885592279694_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=103&ccb=1-7&_nc_sid=e99d92&_nc_eui2=AeEOcV38z9rt8W20hAXAFQ_ZJPrl3QtZ3JMk-uXdC1nckzYLFgcMtqCr18yDfF8facw81opFO0lAG_1GMYluzBrq&_nc_ohc=E9oyveCQJCAQ7kNvwFElwTY&_nc_oc=Admdgb6DVa7YV5wnv12HRDF8zc4F-0yeeu4qqmzYZssKDySKqnVmS254dhf9qWZgKbU&_nc_zt=24&_nc_ht=scontent.fsgn2-9.fna&_nc_gid=Crkf-U9NxHW0Xf9qSXz2pw&oh=00_AfIaCfJYur1DM1FXffMODxCa_EsClaBuO9-b9j0Z0Guulg&oe=683D9C4F"
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
              src="https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-1/480577595_2285369648529429_1739447377459775153_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=111&ccb=1-7&_nc_sid=e99d92&_nc_eui2=AeEqOOK8PPnJyxP0PAAI1A5eGD8rN7pxfhcYPys3unF-FxwnC3fXgI6OCAv4Ej1CEG4MauD6XV2Y_T3v6zm7Tytq&_nc_ohc=-pXN07Gni4UQ7kNvwENkyMt&_nc_oc=AdknH14rfL_uUvwJVk46qlgXmA9kUjSxWFbNFKa7tiLv2sbYmYqRHUrBGM1AwgMM_W0&_nc_zt=24&_nc_ht=scontent.fsgn2-6.fna&_nc_gid=YJUrPdTZqdb4jIJVho4MrA&oh=00_AfL2O-a0YHpRky_w6ARh4ladM8WENLwiwnxN5AQauWkc5w&oe=683DB249"
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