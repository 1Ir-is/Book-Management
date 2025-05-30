package controllers.user;

import models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null && user.getRoleId() == 0) {
            // Nếu là admin → không cho vào trang chủ user
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }
}
