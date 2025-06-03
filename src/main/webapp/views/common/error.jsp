<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>500 - Lỗi hệ thống</title>
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
      background: url("https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?auto=format&fit=crop&w=800&q=80")
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
    .error-details {
      color: #555;
      font-size: 1rem;
      margin-top: 1.5rem;
      text-align: left;
      max-width: 420px;
      background: #f9f9f9;
      padding: 1rem;
      border-radius: 8px;
      box-shadow: 0 2px 8px #0001;
    }
  </style>
</head>
<body>
<div class="oops">Rất tiếc!</div>
<div class="error-title">500 - LỖI HỆ THỐNG</div>
<div class="error-desc">
  Đã xảy ra lỗi trong hệ thống.<br />
  Vui lòng thử lại sau hoặc liên hệ với quản trị viên.
</div>
<%
  if (exception != null) {
%>
<div class="error-details">
  <h4>Chi tiết lỗi:</h4>
  <pre><%= exception.getMessage() %></pre>
</div>
<%
  }
%>
<a href="<%= request.getContextPath() %>/" class="error-btn">
  Quay về trang chủ
</a>
</body>
</html>