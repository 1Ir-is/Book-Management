package controllers.auth;

import models.User;
import services.user.IUserService;
import services.user.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final IUserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userService.login(email, password);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 phut

            // ghi nho dang nhap qua cookie neu co
            if (req.getParameter("remember") != null) {
                Cookie emailCookie = new Cookie("email", email);
                Cookie passCookie = new Cookie("password", password);
                emailCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngay
                passCookie.setMaxAge(7 * 24 * 60 * 60);
                resp.addCookie(emailCookie);
                resp.addCookie(passCookie);
            }

            // phan quyen
            if (user.getRoleId() == 0) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }
}
