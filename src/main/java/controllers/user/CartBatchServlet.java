package controllers.user;

import models.User;
import services.cart.CartService;
import services.cart.ICartService;
import services.order.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/cart/batch")
public class CartBatchServlet extends HttpServlet {
    private static final String CART_PAGE = "/views/user/cart.jsp";
    private static final String ORDER_HISTORY_PAGE = "/views/user/order_history.jsp";
    private static final String LOGIN_PAGE = "/auth/login.jsp";

    private ICartService cartService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        cartService = new CartService();
        orderService = new OrderService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            String action = request.getParameter("action");
            String[] selectedBooks = request.getParameterValues("selectedBooks");

            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect(request.getContextPath() + LOGIN_PAGE);
                return;
            }

            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect(request.getContextPath() + LOGIN_PAGE);
                return;
            }

            Integer userId = user.getUserId(); // Ưu tiên dùng user.getId()

            if (selectedBooks == null || selectedBooks.length == 0) {
                request.setAttribute("error", "Vui lòng chọn ít nhất một sản phẩm.");
                request.getRequestDispatcher(CART_PAGE).forward(request, response);
                return;
            }

            if ("delete".equals(action)) {
                List<Integer> bookIds = new ArrayList<>();
                for (String bookIdStr : selectedBooks) {
                    try {
                        bookIds.add(Integer.parseInt(bookIdStr));
                    } catch (NumberFormatException e) {
                        // Bỏ qua id không hợp lệ (hoặc log lại nếu cần)
                    }
                }

                if (!bookIds.isEmpty()) {
                    cartService.removeItems(userId, bookIds);
                }

                response.sendRedirect(request.getContextPath() + CART_PAGE);

            } else if ("checkout".equals(action)) {
                boolean success = orderService.checkout(userId, selectedBooks);
                if (success) {
                    response.sendRedirect(request.getContextPath() + ORDER_HISTORY_PAGE);
                } else {
                    request.setAttribute("error", "Không thể đặt hàng. Vui lòng thử lại.");
                    request.getRequestDispatcher(CART_PAGE).forward(request, response);
                }

            } else {
                response.sendRedirect(request.getContextPath() + CART_PAGE);
            }

        } catch (Exception e) {
            e.printStackTrace(); // Có thể thay bằng log framework như SLF4J
            request.setAttribute("error", "Đã xảy ra lỗi hệ thống.");
            request.getRequestDispatcher(CART_PAGE).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/views/user/cart.jsp");
    }
}
