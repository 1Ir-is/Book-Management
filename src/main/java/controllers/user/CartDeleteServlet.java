package controllers.user;

import models.User;
import repositories.book.BookRepository;
import repositories.cart.CartRepository;
import repositories.cartdetails.CartDetailsRepository;
import services.cart.CartService;
import services.cart.ICartService;
import utils.JDBCUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/cart/delete")
public class CartDeleteServlet extends HttpServlet {
    private ICartService cartService;

    @Override
    public void init() {
        Connection conn;
        try {
            conn = JDBCUtils.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        cartService = new CartService(
                new CartRepository(conn),
                new CartDetailsRepository(conn),
                new BookRepository()
        );
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        cartService.removeBook(user.getUserId(), bookId);
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
