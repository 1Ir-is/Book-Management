package controllers.user;

import utils.SMTPMailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

@WebServlet("/contact-admin")
public class ContactAdminServlet extends HttpServlet {

    private String loadEmailTemplate(String path) throws IOException {
        try (InputStream inputStream = getServletContext().getResourceAsStream(path);
             Scanner scanner = new Scanner(inputStream, StandardCharsets.UTF_8.name())) {
            scanner.useDelimiter("\\A");
            return scanner.hasNext() ? scanner.next() : "";
        }
    }

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
            req.getSession().setAttribute("error", "Vui lòng điền đầy đủ email và nội dung.");
            resp.sendRedirect(req.getContextPath() + "/contact-admin");
            return;
        }

        try {
            String subject = "📬 Yêu Cầu Liên Hệ Mới từ: " + userEmail;

            Map<String, String> placeholders = new HashMap<>();
            placeholders.put("senderEmail", userEmail);
            placeholders.put("messageText", userMessage);

            String htmlContent = SMTPMailUtil.loadHtmlTemplate("mails/contact_mail.html", placeholders);

            SMTPMailUtil.sendEmail("irissoveriegn@gmail.com", subject, htmlContent);

            req.getSession().setAttribute("success", "Tin nhắn của bạn đã được gửi tới quản trị viên.");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Gửi tin nhắn thất bại. Vui lòng thử lại sau.");
        }


        resp.sendRedirect(req.getContextPath() + "/contact-admin");
    }
}
