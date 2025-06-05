<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên hệ Quản trị viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body { background: #f8f9fa; }
        .contact-container {
            max-width: 450px;
            margin: 40px auto 60px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            padding: 32px 28px 24px 28px;
        }
        .contact-container h1 {
            text-align: center;
            margin-bottom: 24px;
            color: #27ae60;
            font-size: 2rem;
        }
        .success-message {
            background: #eafaf1;
            color: #27ae60;
            border: 1px solid #b2f0d6;
            padding: 12px 16px;
            border-radius: 5px;
            margin-bottom: 18px;
            text-align: center;
            font-weight: 500;
        }
        form label { display: block; margin-bottom: 6px; font-weight: 500; color: #333; }
        form input[type="email"], form textarea {
            width: 100%; padding: 10px 12px; border: 1px solid #ddd; border-radius: 5px;
            margin-bottom: 18px; font-size: 1rem; background: #f9f9f9; transition: border 0.2s;
        }
        form input[type="email"]:focus, form textarea:focus {
            border: 1.5px solid #27ae60; outline: none; background: #fff;
        }
        form button[type="submit"] {
            width: 100%; background: #27ae60; color: #fff; border: none; padding: 12px 0;
            border-radius: 5px; font-size: 1.1rem; font-weight: bold; cursor: pointer; transition: background 0.2s;
        }
        form button[type="submit"]:hover { background: #219150; }
        @media (max-width: 600px) {
            .contact-container { padding: 18px 8px 16px 8px; }
        }
    </style>
</head>
<body>
<!-- header section start -->
<jsp:include page="views/common/header.jsp" />
<!-- header section end -->

<div class="contact-container">
    <h1>Liên hệ Quản trị viên</h1>
    <c:if test="${'POST' == param.method && not empty sessionScope.success}">
        <div class="success-message">
                ${sessionScope.success}
        </div>
        <c:remove var="success" scope="session" />
    </c:if>
    <form method="post" action="${pageContext.request.contextPath}/contact-admin">
        <label for="email">Email của bạn:</label>
        <input type="email" id="email" name="email" placeholder="Nhập email của bạn" required>

        <label for="message">Nội dung:</label>
        <textarea id="message" name="message" placeholder="Nhập nội dung liên hệ..." rows="5" required></textarea>

        <button type="submit">Gửi liên hệ</button>
    </form>
</div>

<!-- footer -->
<jsp:include page="views/common/footer.jsp" />
</body>
</html>