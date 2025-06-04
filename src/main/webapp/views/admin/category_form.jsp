<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminpage.css" />
    <title>${category != null ? "Chỉnh sửa Danh mục" : "Thêm Danh mục"}</title>
    <style>
        .form-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #fff;
        }

        .form-container h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.8rem;
            color: #333;
        }

        .form-group {
            display: flex;
            flex-direction: column; /* Đảm bảo label và input xếp chồng nhau */
            align-items: flex-start; /* Căn label và input theo chiều dọc */
            margin-bottom: 1.5rem;
        }

        .form-group label {
            width: 100%; /* Đảm bảo label chiếm toàn bộ chiều rộng */
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #333;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%; /* Đảm bảo input, select, textarea chiếm toàn bộ chiều rộng */
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box; /* Đảm bảo padding không làm tăng kích thước */
        }
        .form-group input[type="file"] {
            padding: 0.4rem;
        }

        .form-actions {
            margin-top: 1.5rem; /* Tăng khoảng cách giữa các trường và nút hành động */
            display: flex;
            justify-content: space-between;
            gap: 1.5rem; /* Tăng khoảng cách giữa các nút */
        }

        .btn {
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-submit {
            background: #27ae60;
        }

        .btn-submit:hover {
            background: #219150;
        }

        .btn-cancel {
            background: #e74c3c;
        }

        .btn-cancel:hover {
            background: #c0392b;
        }

        .actions {
            margin-top: 1rem; /* Tăng khoảng cách giữa breadcrumb và nút */
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            background: #3498db;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .btn-back:hover {
            background: #2980b9;
        }

        .error-message {
            margin-top: 0.5rem;
            color: red;
            font-size: 0.9rem;
        }

        @media screen and (max-width: 768px) {
            /* Form Container */
            .form-container {
                padding: 1rem; /* Giảm padding để tiết kiệm không gian */
                margin: 1rem; /* Giảm khoảng cách bên ngoài */
            }

            .form-container h1 {
                font-size: 1.5rem; /* Giảm kích thước tiêu đề */
                margin-bottom: 1rem; /* Giảm khoảng cách dưới tiêu đề */
            }

            /* Form Group */
            .form-group {
                margin-bottom: 1rem; /* Giảm khoảng cách giữa các trường */
            }

            .form-group label {
                font-size: 0.9rem; /* Giảm kích thước chữ của label */
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                font-size: 0.9rem; /* Giảm kích thước chữ của input */
                padding: 0.6rem; /* Giảm padding để tiết kiệm không gian */
            }

            /* Form Actions */
            .form-actions {
                flex-direction: column; /* Xếp nút theo chiều dọc */
                gap: 0.8rem; /* Tăng khoảng cách giữa các nút */
            }

            .btn {
                width: 100%; /* Nút chiếm toàn bộ chiều rộng */
                text-align: center;
            }

            /* Breadcrumb and Back Button */
            .actions {
                margin-top: 1rem; /* Tăng khoảng cách giữa breadcrumb và nút */
            }

            .btn-back {
                font-size: 0.9rem; /* Giảm kích thước chữ của nút */
                padding: 0.6rem 1rem; /* Giảm padding của nút */
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
            <h1 class="title">${category != null ? "Chỉnh sửa Danh mục" : "Thêm Danh mục"}</h1>
            <ul class="breadcrumbs">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Trang Chủ</a></li>
                <li class="divider">/</li>
                <li><a href="${pageContext.request.contextPath}/admin/categories">Quản lý Danh Mục</a></li>
                <li class="divider">/</li>
                <li><a href="#" class="active">${category != null ? "Chỉnh sửa Danh mục" : "Thêm Danh mục"}</a></li>
            </ul>
            <div class="actions">
                <a href="${pageContext.request.contextPath}/admin/categories" class="btn-back">
                    <i class="bx bxs-home"></i> Quay lại danh sách
                </a>
            </div>
        </div>
        <div class="form-container">
            <h1>${category != null ? "Chỉnh sửa Danh mục" : "Thêm Danh mục"}</h1>
            <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                <c:if test="${category != null}">
                    <input type="hidden" name="ma_danh_muc" value="${category.categoryId}" />
                </c:if>
                <div class="form-group">
                    <label for="ten_danh_muc">Tên danh mục</label>
                    <input
                            type="text"
                            id="ten_danh_muc"
                            name="ten_danh_muc"
                            value="${category != null ? category.categoryName : ''}"
                            placeholder="Nhập tên danh mục"
                            required
                    />
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-submit">${category != null ? "Cập nhật" : "Thêm mới"}</button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-cancel">Hủy</a>
                </div>
            </form>
        </div>
    </main>
</section>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const form = document.querySelector('form');
        const tenDanhMucInput = document.getElementById('ten_danh_muc');

        form.addEventListener('submit', function (event) {
            clearErrors();

            if (!tenDanhMucInput.value.trim()) {
                showError(tenDanhMucInput, 'Tên danh mục không được để trống.');
                event.preventDefault();
            } else if (tenDanhMucInput.value.length > 100) {
                showError(tenDanhMucInput, 'Tên danh mục không được vượt quá 100 ký tự.');
                event.preventDefault();
            }
        });

        function showError(input, message) {
            const error = document.createElement('div');
            error.className = 'error-message';
            error.style.color = 'red';
            error.style.fontSize = '0.9rem';
            error.textContent = message;
            input.parentElement.appendChild(error);
        }

        function clearErrors() {
            document.querySelectorAll('.error-message').forEach(function (el) {
                el.remove();
            });
        }
    });
</script>
</body>
</html>