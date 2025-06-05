package controllers.admin;


import models.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/profile")
public class AdminProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is logged in and has admin role
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && user.getRoleId() == 0) {
            // Forward to the profile JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/profile.jsp");
            dispatcher.forward(request, response);
        } else {
            // Redirect to an error page or login page
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
