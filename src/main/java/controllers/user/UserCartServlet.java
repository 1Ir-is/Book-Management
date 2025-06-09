package controllers.user;

import models.CartDetails;
import models.Order;
import models.User;
import repositories.book.BookRepository;
import repositories.book.IBookRepository;
import repositories.cart.CartRepository;
import repositories.cart.ICartRepository;
import repositories.cart_details.CartDetailsRepository;
import repositories.cart_details.ICartDetailsRepository;
import repositories.order.IOrderRepository;
import repositories.order.OrderRepository;
import services.cart.CartService;
import services.cart.ICartService;
import services.order.IOrderService;
import services.order.OrderService;
import utils.JDBCUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/user/cart")
public class UserCartServlet extends HttpServlet {
    private ICartService cartService;
    private IOrderService orderService;

    @Override
    public void init() {
        try {
            Connection conn = JDBCUtils.getConnection();
            ICartRepository cartRepo = new CartRepository(conn);
            ICartDetailsRepository cartDetailsRepo = new CartDetailsRepository(conn);
            IBookRepository bookRepo = new BookRepository();
            IOrderRepository orderRepo = new OrderRepository();

            cartService = new CartService(cartRepo, cartDetailsRepo, bookRepo);
            orderService = new OrderService(cartRepo, cartDetailsRepo);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to connect to DB", e);
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "history":
                showOrderHistory(request, response);
                break;
            default:
                showCart(request, response);
        }
    }

    private void showOrderHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        List<Order> orderHistory = orderService.getOrderHistory(user.getUserId());
        request.setAttribute("orders", orderHistory);

        request.getRequestDispatcher("/views/user/order_history.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action == null ? "" : action) {
            case "add":
                addToCart(request, response);
                break;
            case "update":
                updateQuantity(request, response);
                break;
            case "delete":
                deleteItem(request, response);
                break;
            case "batch":
                batchAction(request, response);
                break;
            case "checkout":
                showCheckoutPage(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/user/cart");
        }
    }

    private void showCheckoutPage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<CartDetails> items = cartService.getListInCart(user.getUserId());
        request.setAttribute("cartItems", items);
        request.getRequestDispatcher("/views/user/checkout.jsp").forward(request, response);
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response)
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

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            User user = (User) session.getAttribute("user");
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("soLuong"));

            cartService.addBookToCart(user.getUserId(), bookId, quantity);

            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/cart");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String action = request.getParameter("change");

        try {
            if (action != null) {
                if (action.equals("increase")) {
                    cartService.changeQuantity(userId, bookId, 1);
                } else if (action.equals("decrease")) {
                    cartService.changeQuantity(userId, bookId, -1);
                }
            } else {
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity > 0) {
                    cartService.updateQuantity(userId, bookId, quantity);
                } else {
                    cartService.removeBook(userId, bookId);
                }
            }

            String requestedWith = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(requestedWith)) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.sendRedirect(request.getContextPath() + "/user/cart");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        cartService.removeBook(user.getUserId(), bookId);

        response.sendRedirect(request.getContextPath() + "/user/cart");
    }

    private void batchAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String CART_PAGE = "/views/user/cart.jsp";
        final String LOGIN_PAGE = "/auth/login.jsp";

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + LOGIN_PAGE);
            return;
        }

        User user = (User) session.getAttribute("user");
        Integer userId = user.getUserId();

        String[] selectedBooks = request.getParameterValues("selectedBooks");
        String subAction = request.getParameter("subAction");

        if (selectedBooks == null || selectedBooks.length == 0) {
            request.setAttribute("error", "Vui lòng chọn ít nhất một sản phẩm.");
            request.getRequestDispatcher(CART_PAGE).forward(request, response);
            return;
        }

        List<Integer> bookIds = new ArrayList<>();
        for (String bookIdStr : selectedBooks) {
            try {
                bookIds.add(Integer.parseInt(bookIdStr));
            } catch (NumberFormatException ignored) {}
        }

        if ("delete".equals(subAction)) {
            if (!bookIds.isEmpty()) {
                cartService.removeItems(userId, bookIds);
            }
            response.sendRedirect(request.getContextPath() + "/user/cart");

        } else if ("checkout".equals(subAction)) {
            List<CartDetails> allItems = cartService.getListInCart(userId);
            List<CartDetails> selectedItems = new ArrayList<>();

            for (CartDetails item : allItems) {
                if (bookIds.contains(item.getBookId())) {
                    selectedItems.add(item);
                }
            }

            boolean success = orderService.checkout(userId, selectedItems);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/user/cart?action=history");
            } else {
                request.setAttribute("error", "Không thể đặt hàng. Vui lòng thử lại.");
                request.getRequestDispatcher(CART_PAGE).forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/user/cart");
        }
    }
}
