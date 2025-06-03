<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
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

        .profile-name {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .profile-role,
        .profile-email,
        .profile-phone,
        .profile-address {
            font-size: 1rem;
            margin-bottom: 0.5rem;
            color: #555;
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
                        src="https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg"
                        alt="Admin Profile Picture"
                        class="profile-picture"
                />
                <h2 class="profile-name"><%= user.getName() %></h2>
                <p class="profile-role">Vai Trò: Admin</p>
                <p class="profile-email">Email: <%= user.getEmail() %></p>
                <p class="profile-phone">Số điện thoại: <%= user.getPhoneNumber() %></p>
                <p class="profile-address">Địa chỉ: <%= user.getAddress() %></p>
            </div>
        </div>
    </main>
</section>
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