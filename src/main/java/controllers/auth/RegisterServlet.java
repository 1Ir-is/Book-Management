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
    private final IUserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String ten = req.getParameter("ten");
        String email = req.getParameter("email");
        String matKhau = req.getParameter("mat_khau");
        String soDienThoai = req.getParameter("so_dien_thoai");
        String diaChi = req.getParameter("dia_chi");

        HttpSession session = req.getSession();

        if (userService.isEmailExists(email)) {
            session.setAttribute("registerError", "Email đã được sử dụng!");
            resp.sendRedirect(req.getContextPath() + "/home.jsp");
            return;
        }

        User user = new User(ten, email, matKhau, soDienThoai, diaChi, 1);
        boolean success = userService.register(user);

        if (success) {
            session.setAttribute("registerSuccess", true);
        } else {
            session.setAttribute("registerError", "Đăng ký thất bại. Vui lòng thử lại!");
        }

        resp.sendRedirect(req.getContextPath() + "/home.jsp");
    }

}
