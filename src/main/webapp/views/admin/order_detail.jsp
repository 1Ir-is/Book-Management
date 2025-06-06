<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng</title>
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminpage.css" />
    <style>
        /* Page Header */
        .page-header {
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .page-header .actions {
            display: flex;
            gap: 10px; /* Khoảng cách giữa các nút */
        }

        .page-header .btn-create,
        .page-header .btn-back {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
        }

        .page-header .btn-create {
            background: #27ae60;
        }

        .page-header .btn-create:hover {
            background: #219150;
        }

        .page-header .btn-back {
            background: #3498db;
        }

        .page-header .btn-back:hover {
            background: #2980b9;
        }
        /* Head Section */
        .head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .head .actions a {
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 1rem;
            margin-left: 10px;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
        }

        .head .btn-create {
            background: #27ae60;
        }

        .head .btn-create:hover {
            background: #219150;
        }

        .head .btn-back {
            background: #3498db;
        }

        .head .btn-back:hover {
            background: #2980b9;
        }

        /* Table */
        .table-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }
        .data-table th,
        .data-table td {
            border: 1px solid #ddd;
            padding: 0.8rem;
            text-align: left;
        }

        .data-table th {
            background: #f4f4f4;
        }

        .data-table td {
            background: #fff;
        }

        /* Style for the Select Dropdown */
        select[name="status"] {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        select[name="status"]:hover {
            border-color: #3498db;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        select[name="status"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
        }

        /* Style for the Submit Button */
        button[type="submit"] {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            font-weight: bold;
            color: #fff;
            background-color: #27ae60;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease-in-out;
        }

        button[type="submit"]:hover {
            background-color: #219150;
            transform: scale(1.05);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        button[type="submit"]:focus {
            outline: none;
            box-shadow: 0 0 5px rgba(39, 174, 96, 0.5);
        }

        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0, 0, 0, 0.5); /* Black background with opacity */
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 90%; /* Adjust width */
            max-width: 400px; /* Limit max width */
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .modal-icon {
            font-size: 3rem;
            color: #e74c3c;
            margin-bottom: 1rem;
        }

        .modal-actions {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
            margin-top: 1rem;
        }

        .modal-actions .btn {
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .modal-actions .btn-delete {
            background-color: #e74c3c;
            color: #fff;
        }

        .modal-actions .btn-delete:hover {
            background-color: #c0392b;
        }

        .modal-actions .btn-cancel {
            background-color: #3498db;
            color: #fff;
        }

        .modal-actions .btn-cancel:hover {
            background-color: #2980b9;
        }

        .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 1.5rem;
            color: #333;
            cursor: pointer;
        }

        .close:hover {
            color: #e74c3c;
        }
        /* Toast Message */
        #toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #27ae60;
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 5px;
            z-index: 2000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            font-size: 1rem;
            animation: fadeInOut 3s ease-in-out;
        }

        /* Animation */
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


        /* Responsive for mobile */
        @media screen and (max-width: 768px) {
            /* Thu hẹp khoảng cách nội dung */
            #content {
                margin-left: 0;
                padding: 1rem;
            }

            /* Page Header */
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .page-header .actions {
                display: flex;
                flex-direction: column;
                gap: 0.5rem; /* Khoảng cách giữa các nút */
                width: 100%;
            }

            .page-header .btn-create,
            .page-header .btn-back {
                width: 100%; /* Nút chiếm toàn bộ chiều rộng */
                justify-content: center;
            }

            .table-container {
                width: 100%;
                overflow-x: auto;
                margin-top: 1rem;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            /* Table */
            .data-table {
                width: 100%;
                border-collapse: collapse;
            }

            .data-table th,
            .data-table td {
                border: 1px solid #ddd;
                padding: 0.8rem;
                text-align: left;
            }

            .data-table th {
                font-size: 0.9rem; /* Giảm kích thước chữ tiêu đề */
            }

            .data-table td {
                font-size: 0.85rem; /* Giảm kích thước chữ nội dung */
                word-wrap: break-word; /* Đảm bảo nội dung không tràn */
            }

            .data-table td .action-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 0.3rem;
            }

            .action-buttons {
                display: flex;
                flex-direction: column;
                align-items: stretch;
            }

            /* Nút hành động */
            .btn-edit,
            .btn-delete {
                padding: 0.3rem 0.5rem;
                font-size: 0.8rem;
                display: inline-block;
                margin: 0.2rem 0; /* Tạo khoảng cách giữa các nút */
                width: 100%; /* Nút chiếm toàn bộ chiều rộng */
                text-align: center;
            }

            .btn-edit {
                background: #f39c12;
                color: #fff;
                border-radius: 3px;
            }

            .btn-edit:hover {
                background: #e67e22;
            }

            .btn-delete {
                background: #e74c3c;
                color: #fff;
                border-radius: 3px;
            }

            .btn-delete:hover {
                background: #c0392b;
            }

            main,
            section,
            #content {
                width: 100%;
                overflow-x: hidden;
            }
        }
    </style>
</head>
<body>
<!-- SIDEBAR -->
<jsp:include page="views/common/sidebar.jsp" />
<!-- SIDEBAR -->

<section id="content">
    <!-- NAVBAR -->
    <jsp:include page="views/common/navbar.jsp" />
    <!-- NAVBAR -->
    <main>
        <div class="page-header">
            <h1 class="title">Chi tiết đơn hàng</h1>
            <ul class="breadcrumbs">
                <li><a href="${pageContext.request.contextPath}/admin/orders">Quay lại</a></li>
                <li class="divider">/</li>
                <li><a href="#" class="active">Chi tiết đơn hàng</a></li>
            </ul>
        </div>
        <!-- Display Customer Name -->
        <div class="customer-info">
            <p><strong>Người đặt hàng:</strong> ${customerName}</p>
        </div>
        <div class="table-container">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Tên sách</th>
                    <th>Số lượng</th>
                    <th>Giá / 1 cuốn</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="detail" items="${orderDetails}">
                    <tr>
                        <td>${detail[0]}</td> <!-- Book Name -->
                        <td>${detail[1]}</td> <!-- Quantity -->
                        <td>${detail[2]}</td> <!-- Price -->
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</section>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>