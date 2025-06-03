package controllers.auth;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // Xoá user ra khỏi session
        session.removeAttribute("user");

        // Gửi thông báo thành công
        session.setAttribute("success", "Đăng xuất thành công!");

        // Redirect về trang chủ
        resp.sendRedirect(req.getContextPath() + "/");
    }
}
