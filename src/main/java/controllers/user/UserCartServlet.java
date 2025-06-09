    package controllers.user;
    
    import models.CartDetails;
    import models.User;
    import repositories.book.BookRepository;
    import repositories.book.IBookRepository;
    import repositories.cart.CartRepository;
    import repositories.cart.ICartRepository;
    import repositories.cart_details.CartDetailsRepository;
    import repositories.cart_details.ICartDetailsRepository;
    //import repositories.orderdetails.IOrderDetailsRepository;
    //import repositories.orderdetails.OrderDetailsRepository;
    import repositories.order.IOrderRepository;
    import repositories.order.OrderRepository;
    import services.cart.CartService;
    import services.cart.ICartService;
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
        private OrderService orderService;
    
        @Override
        public void init() {
            try {
                Connection conn = JDBCUtils.getConnection();
                ICartRepository cartRepo = new CartRepository(conn);
                ICartDetailsRepository cartDetailsRepo = new CartDetailsRepository(conn);
                IBookRepository bookRepo = new BookRepository();
                IOrderRepository orderRepository = new OrderRepository();
                cartService = new CartService(cartRepo, cartDetailsRepo, bookRepo);
                orderService = new OrderService();
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
                case "orderDetail":
                    showOrderDetail(request, response);
                    break;
                default:
                    showCart(request, response);
                    break;
            }
        }

        private void showOrderDetail(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
                return;
            }

            int orderId;
            try {
                orderId = Integer.parseInt(request.getParameter("orderId"));
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã đơn hàng không hợp lệ.");
                return;
            }

            List<Object[]> orderDetails = orderService.getOrderDetails(orderId, user.getUserId());
            request.setAttribute("orderDetails", orderDetails);
            request.getRequestDispatcher("/views/user/order-detail.jsp").forward(request, response);
        }


        private void showOrderHistory(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
                return;
            }

            int userId = user.getUserId();

            int page = 1;
            int pageSize = 5; // số đơn hàng trên 1 trang

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException ignored) {}
            }

            List<Object[]> orderList = orderService.getOrdersByUser(userId, page, pageSize);
            int totalOrders = orderService.countOrdersByUser(userId);
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/views/user/order-history.jsp").forward(request, response);
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
            request.getRequestDispatcher("/views/user/cart.jsp").forward(request, response); // Correct path
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
            String action = request.getParameter("change"); // dùng "change" để tránh trùng với "action" chính
    
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
    
                // Check if AJAX (fetch)
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
            final String ORDER_HISTORY_PAGE = "/views/user/order_history.jsp";
            final String LOGIN_PAGE = "/auth/login.jsp";
    
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
    
            Integer userId = user.getUserId();
            String[] selectedBooks = request.getParameterValues("selectedBooks");
            List<Integer> bookIds = new ArrayList<>();
            String subAction = request.getParameter("subAction");
    
            if (selectedBooks == null || selectedBooks.length == 0) {
                request.setAttribute("error", "Vui lòng chọn ít nhất một sản phẩm.");
                request.getRequestDispatcher(CART_PAGE).forward(request, response);
                return;
            }
    
            if ("delete".equals(subAction)) {
                for (String bookIdStr : selectedBooks) {
                    try {
                        bookIds.add(Integer.parseInt(bookIdStr));
                    } catch (NumberFormatException ignored) {
                    }
                }
    
                if (!bookIds.isEmpty()) {
                    cartService.removeItems(userId, bookIds);
                }
                response.sendRedirect(request.getContextPath() + "/user/cart");
    
            } else if ("checkout".equals(subAction)) {
                for (String bookIdStr : selectedBooks) {
                    try {
                        bookIds.add(Integer.parseInt(bookIdStr));
                    } catch (NumberFormatException ignored) {}
                }

                // Lấy toàn bộ item trong giỏ
                List<CartDetails> allItems = cartService.getListInCart(userId);
                List<CartDetails> selectedItems = new ArrayList<>();

                for (CartDetails cartDetails : allItems) {
                    if (bookIds.contains(cartDetails.getBookId())) {
                        selectedItems.add(cartDetails);
                    }
                }

                if (selectedItems.isEmpty()) {
                    request.setAttribute("error", "Không có sản phẩm hợp lệ để đặt hàng.");
                    request.getRequestDispatcher(CART_PAGE).forward(request, response);
                    return;
                }

                boolean success = orderService.checkout(userId, selectedItems);

                if (success) {
                    cartService.removeItems(userId, bookIds); // xoá các sản phẩm đã đặt
                    response.sendRedirect(request.getContextPath() + "/user/cart?action=history");
                } else {
                    request.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại.");
                    request.getRequestDispatcher(CART_PAGE).forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/user/cart");
            }
        }
    }
