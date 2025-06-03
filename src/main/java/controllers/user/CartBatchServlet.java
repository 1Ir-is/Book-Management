package controllers.user;

import models.User;
import services.cart.ICartService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart/batch")
public class CartBatchServlet extends HttpServlet {
    private ICartService cartService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String[] selectedBookIds = request.getParameterValues("selectedBooks");
        String action = request.getParameter("action");

        if (selectedBookIds != null) {
            for (String bookIdStr : selectedBookIds) {
                int bookId = Integer.parseInt(bookIdStr);
                if ("delete".equals(action)) {
                    cartService.removeBook(user.getUserId(), bookId);
                } else if ("checkout".equals(action)) {
                    // Xử lý thanh toán từng sách ở đây
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
