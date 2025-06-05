<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>4Book - Nhà sách trực tuyến</title>
  <link rel="icon" type="image/x-icon" href="${ctx}/assets/image/book-shop.png" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  <link rel="stylesheet" href="${ctx}/assets/css/style.css" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
  

<!-- header section start -->
<jsp:include page="views/common/header.jsp" />
<!-- header section end -->

<!-- Thanh tìm kiếm sách -->
<section class="search-bar">
  <form method="get" action="${ctx}/books" class="search-form">
    <input type="text" name="keyword" placeholder="Tìm theo tên sách..." value="${param.keyword}" />
    <select name="category">
      <option value="">-- Chọn thể loại --</option>
      <c:forEach items="${categories}" var="category">
        <option value="${category.categoryId}" ${param.category == category.categoryId ? 'selected' : ''}>
          ${category.categoryName}
        </option>
      </c:forEach>
    </select>
    <button type="submit" class="btn">Tìm kiếm</button>
  </form>
</section>

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
      <a href="${pageContext.request.contextPath}/books" class="btn">Mua ngay</a>
    </div>

    <div class="books-slider">
      <img src="${pageContext.request.contextPath}/assets/image/table.png" class="stand" alt="Giá sách nổi bật" />
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
        <img src="${ctx}/assets/image/book_1.jpg" alt="" />
      </div>
      <div class="content">
        <h3>Cocogoose</h3>
        <div class="price">369.000đ</div>
      </div>
    </div>
    <!-- 2 box giống nhau -->
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/book_15.png" alt="" />
      </div>
      <div class="content">
        <h3>Black History Month</h3>
        <div class="price">369.000đ</div>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/book_8.png" alt="" />
      </div>
      <div class="content">
        <h3>Music Rock</h3>
        <div class="price">369.000đ</div>
      </div>
    </div>
  </div>
</section>

<!-- arrivals section start -->
<section class="arrivals" id="arrivals">
  <h1 class="heading"><span>Sách Mới Về</span></h1>
  <div class="arrivals-grid">
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/book_11.jpg" alt="" />
      </div>
      <div class="content">
        <h3>Boring Girls A Novel Sara Taylor</h3>
        <div class="price">369.000đ</div>
        <div class="stars">
          <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
          <i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
        </div>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/book_12.png" alt="" />
      </div>
      <div class="content">
        <h3>Thanks Everything</h3>
        <div class="price">369.000đ</div>
        <div class="stars">
          <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
          <i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
        </div>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/book_13.png" alt="" />
      </div>
      <div class="content">
        <h3>Andy Son</h3>
        <div class="price">369.000đ</div>
        <div class="stars">
          <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
          <i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- deal section -->
<section class="deal">
  <div class="content">
    <h3>Ưu đãi trong ngày</h3>
    <h1>Giảm giá đến 50%</h1>
    <p>
      Đừng bỏ lỡ cơ hội sở hữu những cuốn sách yêu thích với mức giá cực sốc!
      Ưu đãi chỉ áp dụng trong hôm nay cho các đầu sách nổi bật, số lượng có hạn.
    </p>
    <a href="${pageContext.request.contextPath}/books" class="btn">Mua ngay</a>
  </div>
  <div class="image">
    <img src="${ctx}/assets/image/about.png" alt="Ưu đãi trong ngày" />
  </div>
</section>

<!-- review section -->
<section class="reviews" id="reviews">
  <h1 class="heading"><span>Đánh Giá</span></h1>
  <div class="reviews-grid">
    <div class="box">
      <img src="${ctx}/assets/image/duy.jpg" alt="Ảnh người dùng 1" />
      <h3>Tôn Thất Duy</h3>
      <p>Sách giao nhanh, đóng gói cẩn thận. Nội dung rất hay và bổ ích.</p>
      <div class="stars">
        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
        <i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
      </div>
    </div>
    <div class="box">
      <img src="${ctx}/assets/image/huy.jpg" alt="Ảnh người dùng 2" />
      <h3>Huỳnh Minh Huy</h3>
      <p>Shop tư vấn nhiệt tình, sách mới nguyên, giá tốt. Rất hài lòng!</p>
      <div class="stars">
        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
        <i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
      </div>
    </div>
    <div class="box">
      <img src="${ctx}/assets/image/vuong.jpg" alt="Ảnh người dùng 3" />
      <h3>Phan Tá Anh Vương</h3>
      <p>Đa dạng đầu sách, chất lượng in tốt. Mình đã giới thiệu bạn bè.</p>
      <div class="stars">
        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
        <i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
      </div>
    </div>
  </div>
</section>

<!-- blog section -->
<section class="blogs" id="blogs">
  <h1 class="heading"><span>Blog</span></h1>
  <div class="blogs-grid">
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/blog_1.jpg" alt="Blog 1" />
      </div>
      <div class="content">
        <h3>Cách chọn một cuốn sách hay</h3>
        <p>
          Khám phá bí quyết lựa chọn sách phù hợp với sở thích và mục tiêu của bạn.
        </p>
        <a href="#" class="btn">Đọc thêm</a>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/blog_2.jpg" alt="Blog 2" />
      </div>
      <div class="content">
        <h3>Top 10 tiểu thuyết nên đọc</h3>
        <p>
          Danh sách những cuốn tiểu thuyết nổi bật mà bạn không nên bỏ qua.
        </p>
        <a href="#" class="btn">Đọc thêm</a>
      </div>
    </div>
    <div class="box">
      <div class="image">
        <img src="${ctx}/assets/image/blog_3.jpg" alt="Blog 3" />
      </div>
      <div class="content">
        <h3>Lợi ích của việc đọc sách mỗi ngày</h3>
        <p>
          Đọc sách mỗi ngày giúp phát triển tư duy, mở rộng kiến thức và kỹ năng sống.
        </p>
        <a href="#" class="btn">Đọc thêm</a>
      </div>
    </div>
  </div>
</section>


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
    <a href="${pageContext.request.contextPath}/register" class="btn">Tham Gia Ngay</a>
  </div>
</div>
<!-- Custom JS file link -->
</body>
</html>