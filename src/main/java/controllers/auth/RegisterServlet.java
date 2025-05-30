package controllers.auth;


import models.User;
import services.user.IUserService;
import services.user.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ten = req.getParameter("ten");
        String email = req.getParameter("email");
        String matKhau = req.getParameter("mat_khau");
        String soDienThoai = req.getParameter("so_dien_thoai");
        String diaChi = req.getParameter("dia_chi");

        if (userService.isEmailExists(email)) {
            req.setAttribute("error", "Email đã được đăng ký!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            return;
        }

        User user = new User(ten, email, matKhau, soDienThoai, diaChi, 1); // 1 = vai trò mặc định user
        boolean success = userService.register(user);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại!");
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        }
    }
}
