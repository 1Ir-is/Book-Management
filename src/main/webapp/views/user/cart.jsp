<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %>
<%
    List<CartDetails> cartItems = (List<CartDetails>) request.getAttribute("cartItems");
%>
<html>
<head>
    <title>Giỏ Hàng</title>
    <style>
        .cart-container {
            max-width: 1000px;
            margin: auto;
            font-family: Arial, sans-serif;
        }

        .cart-header {
            display: flex;
            align-items: center;
            background: #f5f5f5;
            padding: 10px;
            font-weight: bold;
        }

        .cart-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
        }

        .cart-item img {
            width: 80px;
        }

        .item-info {
            flex: 2;
            margin-left: 15px;
        }

        .item-info .price {
            font-weight: bold;
            display: inline-block;
            margin-right: 10px;
        }

        .original-price {
            text-decoration: line-through;
            color: #888;
            font-size: 0.9em;
        }

        .quantity-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            flex: 1;
        }

        .quantity-wrapper button {
            width: 25px;
            height: 25px;
            font-size: 16px;
        }

        .total-price {
            flex: 1;
            color: red;
            font-weight: bold;
            text-align: right;
        }

        .delete-btn-wrapper {
            flex: 0 0 40px;
            display: flex;
            justify-content: center;
        }

        .delete-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 20px;
            color: #900;
        }

        .select-all {
            margin: 15px 0;
        }

        .cart-controls {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .cart-controls button {
            padding: 8px 15px;
            font-size: 14px;
            cursor: pointer;
        }

        input[type="checkbox"] {
            transform: scale(1.2);
            margin-right: 10px;
        }
    </style>
</head>
<body>
<div class="cart-container">
    <h2>Giỏ hàng của bạn</h2>
    <form action="${pageContext.request.contextPath}/cart/batch" method="post">
        <% if (cartItems != null && !cartItems.isEmpty()) { %>

        <div class="select-all">
            <input type="checkbox" id="selectAll" onclick="toggleAll(this)">
            <label for="selectAll">Chọn tất cả (<%= cartItems.size() %> sản phẩm)</label>
        </div>

        <% double total = 0; %>
        <% for (CartDetails item : cartItems) {
            double itemTotal = item.getQuantity() * item.getBook().getPrice();
            total += itemTotal;
        %>
        <div class="cart-item">
            <input type="checkbox" name="selectedBooks" value="<%= item.getBookId() %>">
            <img src="<%= item.getBook().getImgUrl() %>" alt="book">
            <div class="item-info">
                <div><strong><%= item.getBook().getBookName() %></strong></div>
                <div>
                    <span class="price"><%= String.format("%,.0f", item.getBook().getPrice()) %> đ</span>
                    <span class="original-price"><%= item.getBook().getPrice() + 20000 %> đ</span>
                </div>
            </div>

            <div class="quantity-wrapper">
                <!-- Các nút tăng/giảm số lượng -->
                <button class="quantity-btn" type="button" onclick="updateQuantity(<%= item.getBookId() %>, 'decrease')">−</button>
                <span><%= item.getQuantity() %></span>
                <button class="quantity-btn" type="button" onclick="updateQuantity(<%= item.getBookId() %>, 'increase')">+</button>
            </div>

            <div class="total-price">
                <%= String.format("%,.0f", itemTotal) %> đ
            </div>

            <div class="delete-btn-wrapper">
                <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                    <input type="hidden" name="bookId" value="<%= item.getBookId() %>">
                    <button type="submit" class="delete-btn" title="Xóa">🗑</button>
                </form>
            </div>
        </div>
        <% } %>

        <div style="text-align:right; margin-top:10px;">
            <strong>Tổng cộng: <%= String.format("%,.0f", total) %> đ</strong>
        </div>

        <div class="cart-controls">
            <button type="submit" name="action" value="checkout">Thanh toán</button>
            <button type="submit" name="action" value="delete">Xóa đã chọn</button>
        </div>

        <% } else { %>
        <p>Giỏ hàng của bạn đang trống.</p>
        <% } %>
    </form>
    <br>
    <a href="books">← Tiếp tục mua sắm</a>
</div>

<script>
    function toggleAll(source) {
        const checkboxes = document.querySelectorAll('input[name="selectedBooks"]');
        checkboxes.forEach(cb => cb.checked = source.checked);
    }

    // Hàm để cập nhật số lượng sách
    function updateQuantity(bookId, action) {
        // Tạo form ẩn để gửi yêu cầu cập nhật số lượng
        const form = document.createElement('form');
        form.method = 'post';
        form.action = '${pageContext.request.contextPath}/cart/update';

        const hiddenBookId = document.createElement('input');
        hiddenBookId.type = 'hidden';
        hiddenBookId.name = 'bookId';
        hiddenBookId.value = bookId;
        form.appendChild(hiddenBookId);

        const hiddenAction = document.createElement('input');
        hiddenAction.type = 'hidden';
        hiddenAction.name = 'action';
        hiddenAction.value = action;
        form.appendChild(hiddenAction);

        document.body.appendChild(form);
        form.submit();
    }
</script>
</body>
</html>
