<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên hệ Quản trị viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <style>
        body { background: #f8f9fa; }
        .contact-container {
            max-width: 450px;
            margin: 40px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            padding: 32px 28px 24px;
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
        #loading-overlay {
            position: fixed;
            z-index: 2000;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            background: rgba(255,255,255,0.7);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .loading-spinner {
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 2rem;
            color: #27ae60;
            gap: 1rem;
        }
        .loading-spinner i {
            font-size: 3rem;
        }
        form button[disabled] {
            background: #ccc !important;
            cursor: not-allowed;
            color: #333 !important;
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
        form button[type="submit"] {
            text-transform: none !important; /* Thêm dòng này nếu đang bị uppercase */
            font-family: Arial, sans-serif !important;
        }
        form button[type="submit"] strong {
            text-transform: none !important;
            font-weight: bold;
            font-family: inherit;
        }

        form button[type="submit"]:hover { background: #219150; }
        @media (max-width: 600px) {
            .contact-container { padding: 18px 8px 16px 8px; }
        }
    </style>
</head>
<body>

<jsp:include page="views/common/header.jsp" />

<div class="contact-container">
    <h1>Liên hệ Quản trị viên</h1>
    <c:if test="${'POST' == param.method && not empty sessionScope.success}">
        <div class="success-message">
                ${sessionScope.success}
        </div>
        <c:remove var="success" scope="session" />
    </c:if>
    <form id="contactForm" method="post" action="${pageContext.request.contextPath}/contact-admin">
        <label for="email">Email của bạn:</label>
        <input type="email" id="email" name="email" placeholder="Nhập email của bạn"
               required autocapitalize="none" autocomplete="email" style="text-transform: none;">

        <label for="message">Nội dung:</label>
        <textarea id="message" name="message" placeholder="Nhập nội dung liên hệ..." rows="5"
                  required style="text-transform: none;" autocapitalize="none"></textarea>

        <button type="submit">Gửi liên hệ</button>
    </form>
</div>

<div id="loading-overlay" style="display:none;">
    <div class="loading-spinner">
        <i class='bx bx-loader-alt bx-spin'></i>
        <span>Đang xử lý...</span>
    </div>
</div>

<script>
    $(document).ready(function () {
        const $form = $('#contactForm');
        const $submitBtn = $form.find('button[type="submit"]');

        function startCooldown() {
            $submitBtn.prop('disabled', true).text('Gửi lại sau 1 phút');
            setTimeout(() => {
                $submitBtn.prop('disabled', false).text('Gửi liên hệ');
            }, 60000); // 60 giây
        }


        // Khi trang load, kiểm tra localStorage
        function checkCooldownOnLoad() {
            const lastSentStr = localStorage.getItem('lastSent');
            if (lastSentStr) {
                const lastSent = parseInt(lastSentStr, 10);
                if (!isNaN(lastSent)) {
                    const now = Date.now();
                    const timePassed = Math.floor((now - lastSent) / 1000);
                    const remaining = 60 - timePassed;
                    if (remaining > 0) {
                        $submitBtn.prop('disabled', true).text('Gửi lại sau 1 phút');
                        setTimeout(() => {
                            $submitBtn.prop('disabled', false).text('Gửi liên hệ');
                        }, remaining * 1000);
                    } else {
                        $submitBtn.prop('disabled', false).text('Gửi liên hệ');
                    }
                }
            }
        }

        checkCooldownOnLoad();

        $form.on('submit', function (e) {
            e.preventDefault();
            if ($submitBtn.prop('disabled')) {
                toastr.warning('Vui lòng chờ trước khi gửi lại.');
                return;
            }
            $('#loading-overlay').css('display', 'flex');
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/contact-admin',
                data: $form.serialize(),
                success: function () {
                    $('#loading-overlay').hide();
                    toastr.success('Liên hệ đã được gửi thành công!');
                    $form[0].reset();

                    localStorage.setItem('lastSent', Date.now().toString());
                    startCooldown();
                },
                error: function () {
                    $('#loading-overlay').hide();
                    toastr.error('Đã xảy ra lỗi. Vui lòng thử lại!');
                }
            });
        });
    });
</script>



<jsp:include page="views/common/footer.jsp" />
</body>
</html>
