<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>404 - Không tìm thấy trang</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>
    body {
      margin: 0;
      padding: 0;
      background: #fff;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      font-family: "Segoe UI", Arial, sans-serif;
    }
    .oops {
      font-size: 7vw;
      font-weight: bold;
      letter-spacing: 0.1em;
      background: url("https://images.unsplash.com/photo-1462331940025-496dfbfc7564?auto=format&fit=crop&w=800&q=80")
      no-repeat center;
      background-size: cover;
      color: transparent;
      -webkit-background-clip: text;
      background-clip: text;
      margin-bottom: 24px;
      text-align: center;
      line-height: 1;
      user-select: none;
    }
    .error-title {
      font-size: 1.7rem;
      font-weight: 700;
      color: #222;
      margin-bottom: 12px;
      text-align: center;
    }
    .error-desc {
      color: #444;
      font-size: 1.08rem;
      margin-bottom: 2.2rem;
      text-align: center;
      max-width: 420px;
    }
    .error-btn {
      padding: 0.8rem 2.5rem;
      font-size: 1.1rem;
      border: none;
      border-radius: 30px;
      background: #2563eb;
      color: #fff;
      font-weight: 600;
      cursor: pointer;
      box-shadow: 0 4px 16px #2563eb33;
      transition: background 0.2s, box-shadow 0.2s;
      text-decoration: none;
      display: inline-block;
      text-align: center;
    }
    .error-btn:hover {
      background: #1d4ed8;
      box-shadow: 0 6px 24px #2563eb44;
    }
  </style>
</head>
<body>
<div class="oops">Rất tiếc!</div>
<div class="error-title">404 - KHÔNG TÌM THẤY TRANG</div>
<div class="error-desc">
  Trang bạn đang tìm kiếm có thể đã bị xóa<br />
  đổi tên hoặc tạm thời không khả dụng.
</div>
<a href="<%= request.getContextPath() %>/" class="error-btn">
  Quay về trang chủ
</a>
</body>
</html>