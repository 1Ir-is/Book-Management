<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>403 Access Denied</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link
          rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
  />
  <style>
    body {
      background: #f7f8fa;
      margin: 0;
      font-family: "Segoe UI", Arial, sans-serif;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }
    .access-denied-container {
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 4px 24px #0001;
      padding: 48px 32px 40px 32px;
      max-width: 420px;
      width: 100%;
      text-align: center;
    }
    .access-denied-code {
      font-size: 5rem;
      font-weight: 700;
      color: #e74c3c;
      letter-spacing: 8px;
      margin-bottom: 0.5rem;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 18px;
    }
    .access-denied-code .fa-hand {
      font-size: 3.2rem;
      color: #fff;
      background: #e74c3c;
      border-radius: 50%;
      padding: 18px 22px;
      box-shadow: 0 2px 12px #e74c3c33;
      margin: 0 8px;
    }
    .access-denied-title {
      font-size: 1.5rem;
      font-weight: 600;
      margin-bottom: 1rem;
      color: #222;
    }
    .access-denied-desc {
      color: #555;
      font-size: 1.08rem;
      margin-bottom: 2rem;
      line-height: 1.6;
    }
    .access-denied-btn {
      padding: 0.7rem 2.2rem;
      font-size: 1rem;
      border: 1px solid #bbb;
      border-radius: 6px;
      background: #fff;
      color: #222;
      cursor: pointer;
      transition: background 0.2s, color 0.2s;
    }
    .access-denied-btn:hover {
      background: #e74c3c;
      color: #fff;
      border-color: #e74c3c;
    }
  </style>
</head>
<body>
<div class="access-denied-container">
  <div class="access-denied-code">
    4
    <span><i class="fa-solid fa-hand"></i></span>
    3
  </div>
  <div class="access-denied-title">Truy cập bị từ chối</div>
  <div class="access-denied-desc">
    Trang bạn đang cố truy cập bị hạn chế quyền truy cập.<br />
    Vui lòng liên hệ với quản trị viên hệ thống.
  </div>
  <a style="text-decoration: none" href="${pageContext.request.contextPath}/" class="access-denied-btn">
    Quay về trang chủ
  </a>
</div>
</body>
</html>