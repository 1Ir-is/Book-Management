package controllers.user;

import utils.GmailServiceUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/contact-admin")
public class ContactAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("/views/user/contact_admin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String userEmail = req.getParameter("email");
        String userMessage = req.getParameter("message");

        if (userEmail == null || userEmail.trim().isEmpty() || userMessage == null || userMessage.trim().isEmpty()) {
            req.getSession().setAttribute("error", "Please provide both email and message.");
            resp.sendRedirect(req.getContextPath() + "/contact-admin");
            return;
        }

        try {
            String subject = "📬 Yêu Cầu Liên Hệ Mới từ: " + userEmail;
            String templatePath = "mails/contact_mail.html";

            Map<String, String> placeholders = new HashMap<>();
            placeholders.put("senderEmail", userEmail);
            placeholders.put("messageText", userMessage);

            GmailServiceUtil.sendEmail("irissoveriegn@gmail.com", subject, templatePath, placeholders);

            req.getSession().setAttribute("success", "Your message has been sent to the admin.");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Failed to send your message. Please try again later.");
        }

        resp.sendRedirect(req.getContextPath() + "/contact-admin");
    }
}
