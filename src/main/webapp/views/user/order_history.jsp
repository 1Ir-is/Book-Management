<c:forEach var="order" items="${orders}">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <div class="order-summary">
        <p>Mã đơn hàng: ${order.id}</p>
        <p>Ngày đặt: ${order.orderDate}</p>
        <p>Tổng tiền: ${order.total}đ</p>
        <p>Trạng thái: ${order.status}</p>
    </div>

    <table class="table">
        <thead>
        <tr>
            <th>Ảnh</th>
            <th>Tên sách</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="detail" items="${orderDetailMap[order.id]}">
            <tr>
                <td><img src="${detail.book.image}" width="80"/></td>
                <td>${detail.book.title}</td>
                <td>${detail.price}đ</td>
                <td>${detail.quantity}</td>
                <td>${detail.price * detail.quantity}đ</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <hr/>
</c:forEach>
