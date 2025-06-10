package controllers.admin;

import models.User;
import services.user.IUserService;
import services.user.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private final IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy từ khóa tìm kiếm (nếu có)
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";
        keyword = keyword.toLowerCase();

        // Phân trang
        int usersPerPage = 5;
        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {
        }

        // Lấy toàn bộ danh sách người dùng
        List<User> allUsers = userService.getAllUsers();

        // Lọc theo từ khóa
        List<User> filteredUsers = new ArrayList<>();
        for (User user : allUsers) {
            String name = user.getName() != null ? user.getName().toLowerCase() : "";
            String email = user.getEmail() != null ? user.getEmail().toLowerCase() : "";
            if (name.contains(keyword) || email.contains(keyword)) {
                filteredUsers.add(user);
            }
        }

        int totalUsers = filteredUsers.size();
        int totalPages = (int) Math.ceil((double) totalUsers / usersPerPage);
        int startIndex = (currentPage - 1) * usersPerPage;
        int endIndex = Math.min(startIndex + usersPerPage, totalUsers);

        List<User> paginatedUsers = filteredUsers.subList(startIndex, endIndex);

        // Gửi dữ liệu sang JSP
        request.setAttribute("users", paginatedUsers);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/user_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if ("block".equals(action)) {
            userService.blockUser(userId);
            request.getSession().setAttribute("toastMessage", "Tài khoản đã bị khóa!");
        } else if ("unblock".equals(action)) {
            userService.unblockUser(userId);
            request.getSession().setAttribute("toastMessage", "Tài khoản đã được mở khóa!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}