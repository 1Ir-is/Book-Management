<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.0.9/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/adminpage.css" />
    <title>Admin Dashboard</title>
</head>
<body>
<c:if test="${user != null && user.roleId == 0}">
    <!-- SIDEBAR -->
    <jsp:include page="views/common/sidebar.jsp" />
    <!-- SIDEBAR -->

    <!-- NAVBAR -->
    <section id="content">
        <!-- NAVBAR -->
        <jsp:include page="views/common/navbar.jsp" />
        <!-- NAVBAR -->

        <!-- MAIN -->
        <main>
            <h1 class="title">Dashboard</h1>
            <ul class="breadcrumbs">
                <li><a href="#">Home</a></li>
                <li class="divider">/</li>
                <li><a href="#" class="active">Dashboard</a></li>
            </ul>
            <div class="info-data">
                <div class="card">
                    <div class="head">
                        <div>
                            <h2>${totalUsers}</h2>
                            <p>Users</p>
                        </div>
                        <i class="bx bx-user icon"></i>
                    </div>
                    <span class="progress" data-value="${userProgress}%"></span>
                    <span class="label">${userProgress}%</span>
                </div>


                <div class="card">
                    <div class="head">
                        <div>
                            <h2>${totalBooks}</h2>
                            <p>Books</p>
                        </div>
                        <i class="bx bx-book icon"></i>
                    </div>
                    <span class="progress" data-value="${bookProgress}%"></span>
                    <span class="label">${bookProgress}%</span>
                </div>

                <div class="card">
                    <div class="head">
                        <div>
                            <h2>${totalOrders}</h2>
                            <p>Orders</p>
                        </div>
                        <i class="bx bx-cart icon"></i>
                    </div>
                    <span class="progress" data-value="${orderProgress}%"></span>
                    <span class="label">${orderProgress}%</span>
                </div>

                <div class="card">
                    <div class="head">
                        <div>
                            <h2>${totalRevenue}</h2>
                            <p>Total Revenue</p>
                        </div>
                        <i class="bx bx-dollar icon"></i>
                    </div>
                    <span class="progress" data-value="${revenueProgress}%"></span>
                    <span class="label">${revenueProgress}%</span>
                </div>
            </div>

            <div class="data">
                <div class="content-data">
                    <div class="head">
                        <h3>Sales Report</h3>
                        <div class="menu">
                            <i class="bx bx-dots-horizontal-rounded icon"></i>
                            <ul class="menu-link">
                                <li><a href="#">Edit</a></li>
                                <li><a href="#">Save</a></li>
                                <li><a href="#">Remove</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="chart">
                        <div id="chart"></div>
                    </div>
                </div>
                <div class="content-data">
                    <div class="head">
                        <h3>Chatbox</h3>
                        <div class="menu">
                            <i class="bx bx-dots-horizontal-rounded icon"></i>
                            <ul class="menu-link">
                                <li><a href="#">Edit</a></li>
                                <li><a href="#">Save</a></li>
                                <li><a href="#">Remove</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="chat-box">
                        <p class="day"><span>Today</span></p>
                        <div class="msg">
                            <img src="https://images.unsplash.com/photo-1517841905240-472988babdf9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cGVvcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60" alt="" />
                            <div class="chat">
                                <div class="profile">
                                    <span class="username">Alan</span>
                                    <span class="time">18:30</span>
                                </div>
                                <p>Hello</p>
                            </div>
                        </div>
                        <div class="msg me">
                            <div class="chat">
                                <div class="profile">
                                    <span class="time">18:30</span>
                                </div>
                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eaque voluptatum eos quam dolores eligendi exercitationem animi nobis reprehenderit laborum! Nulla.</p>
                            </div>
                        </div>
                        <div class="msg me">
                            <div class="chat">
                                <div class="profile">
                                    <span class="time">18:30</span>
                                </div>
                                <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsam, architecto!</p>
                            </div>
                        </div>
                        <div class="msg me">
                            <div class="chat">
                                <div class="profile">
                                    <span class="time">18:30</span>
                                </div>
                                <p>Lorem ipsum, dolor sit amet.</p>
                            </div>
                        </div>
                    </div>
                    <form action="#">
                        <div class="form-group">
                            <input type="text" placeholder="Type..." />
                            <button type="submit" class="btn-send">
                                <i class="bx bxs-send"></i>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <!-- MAIN -->
    </section>
    <!-- NAVBAR -->

    <script>
        document.querySelectorAll(".progress").forEach(progress => {
            const value = progress.getAttribute("data-value");
            const bar = document.createElement("div");
            bar.style.width = value;
            bar.style.height = "100%";
            bar.style.background = "#00aaff";
            bar.style.transition = "width 0.5s ease-in-out";
            progress.appendChild(bar);
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