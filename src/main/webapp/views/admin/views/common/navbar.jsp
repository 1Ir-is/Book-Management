<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav>
    <i class="bx bx-menu toggle-sidebar"></i>
    <form action="#">
        <div class="form-group">
            <input type="text" placeholder="Search..." />
            <i class="bx bx-search icon"></i>
        </div>
    </form>
    <a href="#" class="nav-link">
        <span class="hello-user">
            Hello, <c:choose>
            <c:when test="${not empty user}">${user.name}</c:when>
            <c:otherwise>Guest</c:otherwise>
        </c:choose>
        </span>
        <i class="bx bxs-bell icon"></i>
        <span class="badge">5</span>
    </a>
    <a href="#" class="nav-link">
        <i class="bx bxs-message-square-dots icon"></i>
        <span class="badge">8</span>
    </a>
    <span class="divider"></span>
    <div class="profile">
        <img
                src="<c:choose>
                    <c:when test="${not empty user and not empty user.avatarUrl}">
                        ${user.avatarUrl}
                    </c:when>
                    <c:otherwise>
                        https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg
                    </c:otherwise>
                 </c:choose>"
                alt="User Avatar"
                style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;"
        />
        <ul class="profile-link">
            <li>
                <a href="${pageContext.request.contextPath}/admin/profile"><i class="bx bxs-user-circle icon"></i> Profile</a>
            </li>
            <li>
                <a href="#"><i class="bx bxs-cog"></i> Settings</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/logout"><i class="bx bxs-log-out-circle"></i> Logout</a>
            </li>
        </ul>
    </div>
</nav>