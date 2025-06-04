package controllers.user;


import models.CartDetails;
import models.User;
import repositories.book.BookRepository;
import repositories.book.IBookRepository;
import repositories.cart.CartRepository;
import repositories.cart.ICartRepository;
import repositories.cartdetails.CartDetailsRepository;
import repositories.cartdetails.ICartDetailsRepository;
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
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ICartService cartService;

    @Override
    public void init() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        ICartRepository cartRepository = new CartRepository(conn);
        ICartDetailsRepository cartDetailsRepository = new CartDetailsRepository(conn);
        IBookRepository bookRepository = new BookRepository();
        cartService = new CartService(cartRepository, cartDetailsRepository, bookRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<CartDetails> items = cartService.getListInCart(user.getUserId());

        request.setAttribute("cartItems", items);
        request.getRequestDispatcher("/views/user/cart.jsp").forward(request, response);
    }
}
