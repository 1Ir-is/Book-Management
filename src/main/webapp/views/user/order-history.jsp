<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%
  Set<Integer> displayedOrderIds = new HashSet<>();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Lịch sử đơn hàng</title>
  <style>
    body {
      background: #f7f7f9;
      font-family: "Roboto", Arial, sans-serif;
      margin: 0;
      padding: 0;
    }
    .history-container {
      max-width: 1100px;
      margin: 5rem auto;
      background: #fff;
      border-radius: 1.2rem;
      box-shadow: 0 2px 16px rgba(0, 0, 0, 0.07);
      padding: 4rem 3rem;
    }
    .history-title {
      font-size: 2.7rem;
      color: #219150;
      font-weight: 700;
      margin-bottom: 2.5rem;
      text-align: center;
    }
    .history-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 2.5rem;
      background: white;
    }
    .history-table th,
    .history-table td {
      padding: 1.5rem 1rem;
      text-align: center;
      vertical-align: middle;
      border-bottom: 1px solid #eee;
      font-size: 1.35rem;
    }
    .history-table th {
      color: #2e8b57;
      background: #f8f8fa;
      font-size: 1.4rem;
    }
    .history-table img {
      width: 70px;
      height: 100px;
      object-fit: cover;
      border-radius: 0.4rem;
      box-shadow: 0 1px 8px #27ae6022;
    }
    .history-status {
      font-weight: 600;
      color: #27ae60;
    }
    .history-status.processing {
      color: #f39c12;
    }
    .history-status.completed {
      color: #27ae60;
    }
    .history-status.cancel {
      color: #e74c3c;
    }
    .empty-message {
      text-align: center;
      font-size: 1.6rem;
      color: #999;
      padding: 3rem 0;
    }
    .pagination {
      text-align: center;
      margin-top: 2.5rem;
    }

    .page-link,
    .page-arrow {
      display: inline-block;
      margin: 0 6px;
      padding: 6px 12px;
      border: 1px solid #ccc;
      border-radius: 4px;
      background: #fff;
      text-decoration: none;
      color: #333;
      font-size: 1.4rem;
      transition: background 0.3s ease;
    }

    .page-link:hover,
    .page-arrow:hover {
      background: #f0f0f0;
    }

    .page-link.active {
      background: #2ecc71;
      color: #fff;
      border-color: #2ecc71;
      font-weight: bold;
    }

    @media (max-width: 600px) {
      .history-container {
        padding: 2rem 1rem;
        margin: 1rem;
      }
      .history-title {
        font-size: 1.8rem;
      }
      .history-table {
        font-size: 1rem;
      }
      .history-table th,
      .history-table td {
        padding: 1rem 0.5rem;
        font-size: 0.9rem;
      }
      .history-table img {
        width: 70px;
        height: 100px;
      }
      .history-status {
        font-size: 0.9rem;
      }
      /* Ẩn cột số lượng và tổng tiền trên mobile nếu cần */
      .history-table th:nth-child(4),
      .history-table td:nth-child(4),
      .history-table th:nth-child(5),
      .history-table td:nth-child(5) {
        display: none;
      }
    }
  </style>
</head>
<body>
<jsp:include page="views/common/header.jsp" />

<section class="history-container">
  <div class="history-title">
    <i class="fas fa-history"></i> Lịch Sử Mua Hàng
  </div>

  <c:if test="${not empty orderList}">
    <table class="history-table">
      <thead>
      <tr>
        <th>Mã đơn</th>
        <th>Ngày đặt</th>
        <th>Tổng tiền</th>
        <th>Trạng thái</th>
        <th>Xem</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="order" items="${orderList}">
        <tr>
          <td>${order[0]}</td>
          <td><fmt:formatDate value="${order[1]}" pattern="dd/MM/yyyy"/></td>
          <td><fmt:formatNumber value="${order[3]}" type="currency" currencySymbol=""/>đ</td>
          <td>
      <span class="history-status
        ${order[2] == 'Đang xử lý' ? 'processing' : ''}
        ${order[2] == 'Đã giao' ? 'completed' : ''}
        ${order[2] == 'Đã hủy' ? 'cancel' : ''}">
          ${order[2]}
      </span>
          </td>
          <td>
            <a href="${pageContext.request.contextPath}/user/cart?action=orderDetail&orderId=${order[0]}">Chi tiết</a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>

    <!-- Phân trang nếu có -->
    <c:if test="${totalPages > 1}">
      <div class="pagination">
        <c:if test="${currentPage > 1}">
          <a href="${pageContext.request.contextPath}/user/cart?action=history&page=${currentPage - 1}" class="page-arrow">❮</a>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
          <a href="${pageContext.request.contextPath}/user/cart?action=history&page=${i}"
             class="page-link ${i == currentPage ? 'active' : ''}">
              ${i}
          </a>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
          <a href="${pageContext.request.contextPath}/user/cart?action=history&page=${currentPage + 1}" class="page-arrow">❯</a>
        </c:if>
      </div>
    </c:if>



  </c:if>

  <c:if test="${empty orderList}">
    <div class="empty-message">
      <p>🛒 Bạn chưa có đơn hàng nào.</p>
    </div>
  </c:if>
</section>

<jsp:include page="views/common/footer.jsp" />
</body>
</html>
