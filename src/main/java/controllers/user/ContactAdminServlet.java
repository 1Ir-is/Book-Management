package controllers.user;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/contact-admin")
public class ContactAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/user/contact_admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String message = req.getParameter("message");

        // Here, you can implement logic to send the message to the admin (e.g., via email or save to the database)
        System.out.println("Message from: " + email);
        System.out.println("Message content: " + message);

        // Redirect back with a success message
        req.getSession().setAttribute("success", "Your message has been sent to the admin.");
        resp.sendRedirect(req.getContextPath() + "/contact-admin");
    }
}