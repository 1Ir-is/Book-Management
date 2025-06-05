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
        // Redirect to the home page with the login form
        resp.sendRedirect(req.getContextPath() + "/");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userService.login(email, password);
        if (user != null) {
            if (!user.isStatus()) { // Check if the account is blocked
                req.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
                req.getRequestDispatcher("views/user/home.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            session.setAttribute("success", "Đăng nhập thành công!");

            if (req.getParameter("remember") != null) {
                Cookie emailCookie = new Cookie("email", email);
                Cookie passCookie = new Cookie("password", password);
                emailCookie.setMaxAge(7 * 24 * 60 * 60);
                passCookie.setMaxAge(7 * 24 * 60 * 60);
                resp.addCookie(emailCookie);
                resp.addCookie(passCookie);
            }

            if (user.getRoleId() == 0) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            req.getRequestDispatcher("views/user/home.jsp").forward(req, resp);
        }
    }
}