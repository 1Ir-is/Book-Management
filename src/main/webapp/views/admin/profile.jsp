<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminpage.css" />
    <title>Thông tin cá nhân</title>
    <style>
        .profile-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #fff;
            text-align: center;
        }

        .profile-card {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 1rem;
        }

        .profile-form .form-group {
            margin-bottom: 1rem;
            text-align: left;
        }

        .profile-form .form-group label {
            font-size: 1rem;
            color: #555;
            margin-bottom: 0.5rem;
            display: block;
        }

        .profile-form .form-group input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .profile-save-btn {
            display: block;
            width: 100%;
            padding: 0.8rem;
            background: #27ae60;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }

        .profile-save-btn:hover {
            background: #219150;
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
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 2000;
        }

        .modal-content {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            text-align: center;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .modal-icon {
            margin-bottom: 1rem;
        }

        .modal h2 {
            margin: 0 0 1rem;
            font-size: 1.5rem;
        }

        .modal p {
            margin: 0 0 1.5rem;
            font-size: 1rem;
            color: #555;
        }

        .btn-close {
            background: #27ae60;
            color: #fff;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-close:hover {
            background: #219150;
        }

        .close {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 1.5rem;
            cursor: pointer;
        }

        @keyframes fadeInOut {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            10% {
                opacity: 1;
                transform: translateY(0);
            }
            90% {
                opacity: 1;
                transform: translateY(0);
            }
            100% {
                opacity: 0;
                transform: translateY(-20px);
            }
        }
    </style>
</head>
<body>
<c:if test="${user != null && user.roleId == 0}">
    <!-- SIDEBAR -->
    <jsp:include page="views/common/sidebar.jsp" />
    <!-- SIDEBAR -->

    <section id="content">
        <!-- NAVBAR -->
        <jsp:include page="views/common/navbar.jsp" />
        <!-- NAVBAR -->

        <main>
            <div class="page-header">
                <h1 class="title">Thông tin cá nhân</h1>
                <ul class="breadcrumbs">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Trang Chủ</a></li>
                    <li class="divider">/</li>
                    <li><a href="#" class="active">Thông tin</a></li>
                </ul>
            </div>
            <div class="profile-container">
                <div class="profile-card">
                    <img
                            src="${user.avatarUrl != null ? user.avatarUrl : 'https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg'}"
                            alt="Admin Profile Picture"
                            class="profile-picture"
                    />
                    <form class="profile-form" action="${pageContext.request.contextPath}/admin/update-profile" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label>Họ và Tên</label>
                            <input type="text" name="name" value="${user.name}" required />
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" value="${user.email}" readonly />
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type="text" name="phone" value="${user.phoneNumber}" />
                        </div>
                        <div class="form-group">
                            <label>Địa chỉ</label>
                            <input type="text" name="address" value="${user.address}" />
                        </div>
                        <div class="form-group">
                            <label>Ảnh đại diện</label>
                            <input type="file" name="avatar" accept="image/*" />
                        </div>
                        <button type="submit" class="profile-save-btn">Lưu thay đổi</button>
                    </form>
                </div>
            </div>
        </main>
    </section>
    <div id="loading-overlay" style="display:none;">
        <div class="loading-spinner">
            <i class='bx bx-loader-alt bx-spin'></i>
            <span>Đang xử lý...</span>
        </div>
    </div>

    <div id="resultModal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="closeModal()" title="Đóng">&times;</span>
            <div id="modalIcon" class="modal-icon"></div>
            <h2 id="modalTitle"></h2>
            <p id="modalMessage"></p>
            <button class="btn btn-close" onclick="closeModal()">Đóng</button>
        </div>
    </div>

    <c:if test="${success}">
    <script>
            document.addEventListener('DOMContentLoaded', function () {
                showModal('success', 'Cập nhật thành công!', 'Thông tin của bạn đã được cập nhật.');
            });
        </script>
    </c:if>

    <c:if test="${error}">
    <script>
            document.addEventListener('DOMContentLoaded', function () {
                showModal('error', 'Cập nhật thất bại!', 'Đã xảy ra lỗi khi cập nhật thông tin.');
            });
        </script>
    </c:if>
    <%
        session.removeAttribute("success");
        session.removeAttribute("error");
    %>

    <script>
        function showModal(type, title, message) {
            const modal = document.getElementById('resultModal');
            const modalIcon = document.getElementById('modalIcon');
            const modalTitle = document.getElementById('modalTitle');
            const modalMessage = document.getElementById('modalMessage');

            modalIcon.innerHTML = type === 'success'
                ? '<i class="bx bx-check-circle" style="color: #27ae60; font-size: 3rem;"></i>'
                : '<i class="bx bx-error-circle" style="color: #e74c3c; font-size: 3rem;"></i>';
            modalTitle.textContent = title;
            modalMessage.textContent = message;

            modal.style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('resultModal').style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function () {
            const form = document.querySelector('.profile-form');
            if (form) {
                form.addEventListener('submit', function () {
                    document.getElementById('loading-overlay').style.display = 'flex';
                });
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</c:if>
<c:if test="${user == null || user.roleId != 0}">
    <p>Bạn không có quyền truy cập vào trang này.</p>
</c:if>

</body>
</html>