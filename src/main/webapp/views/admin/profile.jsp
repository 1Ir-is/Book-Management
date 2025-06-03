<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<%
    Boolean success = (Boolean) request.getAttribute("success");
    Boolean error = (Boolean) request.getAttribute("error");
%>
<% if (success != null && success) { %>
<p style="color: green;">Cập nhật thành công!</p>
<% } else if (error != null && error) { %>
<p style="color: red;">Có lỗi xảy ra khi cập nhật.</p>
<% } %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/adminpage.css" />
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
    </style>
</head>
<body>
<%
    if (user != null && user.getRoleId() == 0) {
%>
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
                <li><a href="<%= request.getContextPath() %>/admin/dashboard">Trang Chủ</a></li>
                <li class="divider">/</li>
                <li><a href="#" class="active">Thông tin</a></li>
            </ul>
        </div>
        <div class="profile-container">
            <div class="profile-card">
                <img
                        src="<%= user.getAvatarUrl() != null ? user.getAvatarUrl() : "https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg" %>"
                        alt="Admin Profile Picture"
                        class="profile-picture"
                />
                <form class="profile-form" action="<%= request.getContextPath() %>/admin/update-profile" method="post" enctype="multipart/form-data">
                <div class="form-group">
                        <label>Họ và Tên</label>
                        <input type="text" name="name" value="<%= user.getName() %>" required />
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" value="<%= user.getEmail() %>" readonly />
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" value="<%= user.getPhoneNumber() %>" />
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ</label>
                        <input type="text" name="address" value="<%= user.getAddress() %>" />
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

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var form = document.querySelector('.profile-form');
        if (form) {
            form.addEventListener('submit', function() {
                document.getElementById('loading-overlay').style.display = 'flex';
            });
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="<%= request.getContextPath() %>/assets/js/script.js"></script>
<%
} else {
%>
<p>Bạn không có quyền truy cập vào trang này.</p>
<%
    }
%>
</body>
</html>