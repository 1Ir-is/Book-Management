package controllers.user;

import models.User;
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

@WebServlet("/cart/update")
public class CartUpdateServlet extends HttpServlet {
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
                new CartDetailsRepository(conn)
        );
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
        int userId = user.getUserId();
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String action = request.getParameter("action");

        if (action != null) {
            // Nếu là "increase" hoặc "decrease"
            if (action.equals("increase")) {
                cartService.changeQuantity(userId, bookId, 1);
            } else if (action.equals("decrease")) {
                cartService.changeQuantity(userId, bookId, -1);
            }
        } else {
            // Trường hợp nhập số lượng thủ công
            String quantityStr = request.getParameter("quantity");
            try {
                int quantity = Integer.parseInt(quantityStr);
                if (quantity > 0) {
                    cartService.updateQuantity(userId, bookId, quantity);
                } else {
                    // Nếu nhập 0 hoặc âm thì bạn có thể chọn xóa khỏi giỏ luôn nếu muốn
                    cartService.removeBook(userId, bookId); // nếu bạn có hàm này
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }

        // Kiểm tra nếu request đến từ fetch(), trả JSON; nếu không thì redirect
        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}

