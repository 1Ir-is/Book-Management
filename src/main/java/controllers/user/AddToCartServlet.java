package controllers.user;

import models.User;
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

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private ICartService cartService;

    @Override
    public void init() {
        Connection conn = null;
        try {
            conn = JDBCUtils.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        ICartRepository gioHangRepo = new CartRepository(conn);
        ICartDetailsRepository chiTietRepo = new CartDetailsRepository(conn);
        cartService = new CartService(gioHangRepo, chiTietRepo);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));

            cartService.addBookToCart(user.getUserId(), bookId, soLuong);

            response.sendRedirect(request.getContextPath() + "/cart"); // hoặc trở lại trang chi tiết
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
