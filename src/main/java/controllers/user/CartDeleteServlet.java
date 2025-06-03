package controllers.user;

import models.User;
import services.cart.ICartService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cart/delete")
public class CartDeleteServlet extends HttpServlet {
    private ICartService cartService;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        cartService.removeBook(user.getUserId(), bookId);
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
