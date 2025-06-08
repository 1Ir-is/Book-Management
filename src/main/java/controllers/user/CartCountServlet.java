package controllers.user;

import models.User;
import repositories.book.BookRepository;
import repositories.book.IBookRepository;
import repositories.cart.CartRepository;
import repositories.cart.ICartRepository;
import repositories.cart_details.CartDetailsRepository;
import repositories.cart_details.ICartDetailsRepository;
import services.cart.CartService;
import services.cart.ICartService;
import utils.JDBCUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/cart/count")
public class CartCountServlet extends HttpServlet {
    private ICartService cartService;

    @Override
    public void init() {
        try {
            Connection conn = JDBCUtils.getConnection();
            ICartRepository cartRepo = new CartRepository(conn);
            ICartDetailsRepository cartDetailsRepo = new CartDetailsRepository(conn);
            IBookRepository bookRepo = new BookRepository();

            cartService = new CartService(cartRepo, cartDetailsRepo, bookRepo);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to connect to DB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession(false);

        int count = 0;
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            count = cartService.countItemsInCart(user.getUserId());
        }

        response.getWriter().write("{\"count\":" + count + "}");
    }
}
