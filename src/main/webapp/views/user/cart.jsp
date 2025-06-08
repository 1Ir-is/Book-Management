<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.CartDetails" %>
<%@ page import="java.util.List" %>
<%
    List<CartDetails> cartItems = (List<CartDetails>) request.getAttribute("cartItems");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<html>
<head>
    <title>Giỏ Hàng</title>
    <style>
        /* CSS giữ nguyên như trước */
        .cart-container {
            max-width: 1000px;
            margin: auto;
            font-family: Arial, sans-serif;
        }

        .cart-header, .cart-item {
            display: flex;
            align-items: center;
        }

        .cart-header {
            background: #f5f5f5;
            padding: 10px;
            font-weight: bold;
        }

        .cart-item {
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
    <form action="${pageContext.request.contextPath}/cart?action=batch" method="post">

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
                        <button type="button" onclick="deleteItem(${item.bookId})">Xóa</button>
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
    <a href="books">← Tiếp tục mua sắm</a>
</div>

<script>

    function toggleAll(source) {
        const checkboxes = document.querySelectorAll('input[name="selectedBooks"]');
        checkboxes.forEach(cb => cb.checked = source.checked);
    }

    function updateQuantity(bookId, change) {
        const form = document.createElement('form');
        form.method = 'post';
        form.action = '${pageContext.request.contextPath}/cart?action=update';

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
        form.action = '${pageContext.request.contextPath}/cart?action=delete';

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'bookId';
        input.value = bookId;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
</script>

</body>
</html>
