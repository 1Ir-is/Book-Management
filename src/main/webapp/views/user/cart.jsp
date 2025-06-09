<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %>
<%
  List<CartDetails> cartItems = (List<CartDetails>) request.getAttribute("cartItems");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Giỏ Hàng | 4Book</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

  <style>
    /* ...existing code... */
    .cart-container {
      max-width: 900px;
      margin: 32px auto 24px auto;
      background: #fff;
      border-radius: 14px;
      box-shadow: 0 4px 24px #0001;
      padding: 32px 32px 24px 32px;
      font-family: 'Segoe UI', Arial, sans-serif;
      font-size: 1.18rem;
    }

    .cart-container h2 {
      font-size: 2.2rem;
      font-weight: 700;
      margin-bottom: 18px;
      color: #219150;
      text-align: center;
    }

    .select-all {
      margin: 18px 0 10px 0;
      font-size: 1.18rem;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .cart-item {
      display: flex;
      align-items: center;
      border-bottom: 1px solid #f0f0f0;
      padding: 22px 0;
      gap: 18px;
      font-size: 1.18rem;
    }

    .cart-item:last-child {
      border-bottom: none;
    }

    .cart-item img {
      width: 80px;
      height: 104px;
      object-fit: cover;
      border-radius: 8px;
      box-shadow: 0 2px 8px #0001;
    }

    .item-info {
      flex: 2;
      margin-left: 10px;
    }

    .item-info strong {
      font-size: 1.18rem;
      color: #222;
    }

    .item-info .price {
      font-weight: bold;
      color: #219150;
      margin-right: 10px;
      font-size: 1.12rem;
    }

    .original-price {
      text-decoration: line-through;
      color: #aaa;
      font-size: 1.05em;
    }

    .quantity-wrapper {
      display: flex;
      align-items: center;
      gap: 10px;
      flex: 1;
      justify-content: center;
    }

    .quantity-wrapper button {
      width: 36px;
      height: 36px;
      font-size: 1.3rem;
      border: 1.5px solid #2196f3;
      background: #f5f7fa;
      color: #2196f3;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.2s, color 0.2s;
      font-weight: bold;
    }

    .quantity-wrapper button:hover {
      background: #e3f2fd;
      color: #1769aa;
    }

    .quantity-input {
      width: 56px;
      text-align: center;
      font-size: 1.18rem;
      border: 1.5px solid #ddd;
      border-radius: 8px;
      padding: 6px 0;
      background: #fff;
    }

    .total-price {
      flex: 1;
      color: #e74c3c;
      font-weight: bold;
      text-align: right;
      font-size: 1.18rem;
    }

    .delete-btn-wrapper {
      flex: 0 0 80px;
      display: flex;
      justify-content: center;
    }

    .delete-btn {
      background: #fff0f0;
      border: 1.5px solid #e74c3c;
      cursor: pointer;
      font-size: 1.18rem;
      color: #e74c3c;
      padding: 10px 22px;
      border-radius: 10px;
      font-weight: 600;
      min-width: 100px;
      min-height: 48px;
      transition: background 0.2s, color 0.2s, border 0.2s;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .delete-btn:hover {
      background: #e74c3c;
      color: #fff;
      border: 1.5px solid #e74c3c;
    }

    .cart-controls {
      margin-top: 32px;
      display: flex;
      justify-content: flex-end;
      gap: 16px;
    }

    .cart-controls button {
      padding: 12px 28px;
      font-size: 1.18rem;
      border-radius: 10px;
      border: none;
      font-weight: 600;
      background: #27ae60;
      color: #fff;
      cursor: pointer;
      transition: background 0.2s;
      min-width: 140px;
      min-height: 48px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .cart-controls button.btn-success {
      background: #27ae60;
    }

    .cart-controls button.btn-success:hover {
      background: #219150;
    }

    .cart-controls button:not(.btn-success) {
      background: #f2f2f2;
      color: #222;
      border: 1.5px solid #ddd;
    }

    .cart-controls button:not(.btn-success):hover {
      background: #e0e0e0;
    }

    #grand-total {
      color: #27ae60;
      font-size: 1.35rem;
      font-weight: bold;
    }

    input[type="checkbox"] {
      accent-color: #27ae60;
      width: 22px;
      height: 22px;
      margin-right: 8px;
      cursor: pointer;
      border-radius: 5px;
      border: 1.5px solid #27ae60;
      transition: box-shadow 0.2s;
      box-shadow: 0 1px 4px #0001;
    }

    input[type="checkbox"]:hover {
      box-shadow: 0 0 0 2px #27ae6033;
    }

    a[href="books"] {
      display: inline-block;
      margin-top: 18px;
      font-size: 1.18rem;
      color: #2196f3;
      background: #e3f2fd;
      padding: 12px 28px;
      border-radius: 10px;
      text-decoration: none;
      font-weight: 600;
      transition: background 0.2s, color 0.2s;
      min-width: 180px;
      text-align: center;
    }

    a[href="books"]:hover {
      background: #2196f3;
      color: #fff;
    }

    @media (max-width: 700px) {
      .cart-container {
        padding: 8px 2vw 8px 2vw;
        max-width: 100vw;
        border-radius: 8px;
        font-size: 1rem;
      }
      .cart-item {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
        padding: 10px 0;
        font-size: 1rem;
      }
      .cart-item img {
        width: 60px;
        height: 80px;
      }
      .item-info {
        margin-left: 0;
        width: 100%;
      }
      .quantity-wrapper {
        justify-content: flex-start;
        width: 100%;
        gap: 6px;
      }
      .quantity-wrapper button {
        width: 32px;
        height: 32px;
        font-size: 1.1rem;
        padding: 0;
      }
      .quantity-input {
        width: 40px;
        font-size: 1rem;
        padding: 4px 0;
      }
      .total-price {
        text-align: left;
        width: 100%;
        margin-top: 2px;
        font-size: 1rem;
      }
      .delete-btn-wrapper {
        justify-content: flex-start;
        width: 100%;
        margin-top: 2px;
      }
      .delete-btn {
        padding: 4px 10px;
        font-size: 0.85rem;
        border-radius: 4px;
        width: fit-content;
        min-width: unset;
        max-width: 70px;
        white-space: nowrap;
        display: inline-block; /* hoặc flex nếu cần */
        margin: 0; /* bỏ auto */
      }



      .cart-controls {
        flex-direction: column;
        gap: 8px;
        align-items: stretch;
        margin-top: 18px;
      }
      .cart-controls button {
        width: 100%;
        min-width: unset;
        min-height: 40px;
        font-size: 1rem;
        padding: 10px 0;
        border-radius: 7px;
      }
      .return-books {
        width: 100%;
        text-align: center;
        margin-top: 18px;
        font-size: 1rem;
        padding: 10px 0;
        min-width: unset;
        border-radius: 7px;
      }
      .select-all {
        font-size: 1rem;
        gap: 6px;
      }
      input[type="checkbox"] {
        width: 18px;
        height: 18px;
        margin-right: 6px;
      }
    }
  </style>
</head>
<body>
<jsp:include page="views/common/header.jsp" />
<div class="cart-container">
  <h2>Giỏ hàng của bạn</h2>
  <form action="${pageContext.request.contextPath}/user/cart?action=batch" method="post">

    <c:if test="${not empty cartItems}">
      <div class="select-all">
        <input type="checkbox" id="selectAll" onclick="toggleAll(this)">
        <label for="selectAll">Chọn tất cả (${fn:length(cartItems)} sản phẩm)</label>
      </div>

      <c:set var="grandTotal" value="0"/>
      <c:forEach var="item" items="${cartItems}">
        <c:set var="itemTotal" value="${item.quantity * item.book.price}"/>
        <c:set var="grandTotal" value="${grandTotal + itemTotal}"/>

        <div class="cart-item">
          <input type="checkbox" name="selectedBooks" value="${item.bookId}">
          <img src="${item.book.imgUrl}" alt="book">
          <div class="item-info">
            <div><strong>${item.book.bookName}</strong></div>
            <div>
              <span class="price">
                  <fmt:formatNumber value="${item.book.price}" type="number" groupingUsed="true"/> đ
              </span>
              <span class="original-price">
                  <fmt:formatNumber value="${item.book.price + 20000}" type="number" groupingUsed="true"/> đ
              </span>
            </div>
          </div>

          <div class="quantity-wrapper">
            <button type="button" onclick="updateQuantity(${item.bookId}, 'decrease')">−</button>
            <input
                    type="number"
                    name="quantity_${item.bookId}"
                    value="${item.quantity}"
                    min="1"
                    class="quantity-input"
                    data-book-id="${item.bookId}"
                    data-price="${item.book.price}"
                    style="width: 50px; text-align: center;"
            >
            <button type="button" onclick="updateQuantity(${item.bookId}, 'increase')">+</button>
          </div>

          <div class="total-price" id="total-price-${item.bookId}">
            <fmt:formatNumber value="${itemTotal}" type="number" groupingUsed="true"/> đ
          </div>

          <div class="delete-btn-wrapper">
            <button class="delete-btn" type="button" onclick="deleteItem(${item.bookId})">Xóa</button>
          </div>
        </div>
      </c:forEach>

      <div style="text-align:right; margin-top:10px;">
        <strong>Tổng cộng: <span id="grand-total">
          <fmt:formatNumber value="${grandTotal}" type="number" groupingUsed="true"/> đ
        </span></strong>
      </div>

      <div class="cart-controls">
        <button type="submit" name="subAction" value="checkout" class="btn btn-success">Đặt hàng</button>
        <button type="submit" name="subAction" value="delete">Xóa đã chọn</button>
      </div>

    </c:if>

    <c:if test="${empty cartItems}">
      <p>Giỏ hàng của bạn đang trống.</p>
    </c:if>
  </form>

  <br>
  <a class="return-books" href="${pageContext.request.contextPath}/books">← Tiếp tục mua sắm</a>
</div>

<jsp:include page="views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
  document.querySelector("form").addEventListener("submit", function (e) {
    e.preventDefault(); // Ngăn form submit theo cách truyền thống

    const form = e.target;
    const formData = new FormData(form);
    const actionUrl = form.action;

    fetch(actionUrl, {
      method: "POST",
      body: formData,
      headers: {
        "X-Requested-With": "XMLHttpRequest"
      }
    })
            .then(response => {
              if (!response.ok) throw new Error("Có lỗi xảy ra");

              return response.json(); // Backend sẽ trả JSON
            })
            .then(data => {
              if (data.success) {
                Swal.fire({
                  toast: true,
                  position: 'top-end',
                  icon: 'success',
                  title: data.message,
                  showConfirmButton: false,
                  timer: 2000
                });

                // Làm mới nội dung giỏ hàng bằng fetch lại HTML (có thể AJAX lại phần cartItems)
                setTimeout(() => location.reload(), 2000);
              } else {
                Swal.fire({
                  toast: true,
                  position: 'top-end',
                  icon: 'error',
                  title: data.message,
                  showConfirmButton: false,
                  timer: 2500
                });
              }
            })
            .catch(error => {
              console.error("Lỗi:", error);
              Swal.fire({
                toast: true,
                position: 'top-end',
                icon: 'error',
                title: "Đã xảy ra lỗi",
                showConfirmButton: false,
                timer: 2500
              });
            });
  });
</script>


<script>
  const contextPath = '<%= request.getContextPath() %>';

  function toggleAll(source) {
    const checkboxes = document.querySelectorAll('input[name="selectedBooks"]');
    checkboxes.forEach(cb => cb.checked = source.checked);
  }

  function updateQuantity(bookId, change) {
    const form = document.createElement('form');
    form.method = 'post';
    form.action = contextPath + '/user/cart?action=update';

    const input1 = document.createElement('input');
    input1.type = 'hidden';
    input1.name = 'bookId';
    input1.value = bookId;
    form.appendChild(input1);

    const input2 = document.createElement('input');
    input2.type = 'hidden';
    input2.name = 'change';
    input2.value = change;
    form.appendChild(input2);

    document.body.appendChild(form);
    form.submit();
  }

  const quantityInputs = document.querySelectorAll('.quantity-input');
  quantityInputs.forEach(input => {
    input.addEventListener('input', () => {
      const bookId = input.dataset.bookId;
      const price = parseFloat(input.dataset.price);
      const quantity = parseInt(input.value) || 0;
      const itemTotal = price * quantity;
      document.getElementById('total-price-' + bookId).innerText = itemTotal.toLocaleString('vi-VN') + ' đ';
      updateTotalAll();
    });
  });

  function updateTotalAll() {
    let total = 0;
    document.querySelectorAll('.quantity-input').forEach(input => {
      const price = parseFloat(input.dataset.price);
      const quantity = parseInt(input.value) || 0;
      total += price * quantity;
    });
    document.getElementById('grand-total').innerText = total.toLocaleString('vi-VN') + ' đ';
  }

  function deleteItem(bookId) {
    const form = document.createElement('form');
    form.method = 'post';
    form.action = contextPath + '/user/cart?action=delete';

    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'bookId';
    input.value = bookId;

    form.appendChild(input);
    document.body.appendChild(form);
    form.submit();
  }
</script>


<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
