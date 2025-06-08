package controllers.user;

import models.Order;
import models.OrderDetail;
import models.User;
import repositories.cart.CartRepository;
import repositories.cart.ICartRepository;
import repositories.cartdetails.CartDetailsRepository;
import repositories.cartdetails.ICartDetailsRepository;
import repositories.order.IOrderRepository;
import repositories.order.OrderRepository;
import repositories.orderdetails.IOrderDetailsRepository;
import repositories.orderdetails.OrderDetailsRepository;
import services.order.OrderService;
import services.orderdetail.OrderDetailService;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    private OrderService orderService;
    private OrderDetailService orderDetailService;

    @Override
    public void init() {
        try {
            Connection conn = JDBCUtils.getConnection();
            IOrderRepository orderRepo = new OrderRepository(conn);
            IOrderDetailsRepository detailsRepo = new OrderDetailsRepository(conn);
            ICartRepository cartRepo = new CartRepository(conn);
            ICartDetailsRepository cartDetailsRepo = new CartDetailsRepository(conn);
            orderDetailService = new OrderDetailService(detailsRepo); // Gán service
            orderService = new OrderService(orderRepo, detailsRepo, cartRepo, cartDetailsRepo);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Order> orders = orderService.getOrdersByUserId(user.getUserId());
        Map<Integer, List<OrderDetail>> orderDetailMap = new HashMap<>();
        for (Order order : orders) {
            List<OrderDetail> details = orderDetailService.getDetailsByOrderId(order.getOrderId());
            orderDetailMap.put(order.getOrderId(), details);
        }

        request.setAttribute("orders", orders);
        request.setAttribute("orderDetailMap", orderDetailMap);
        request.getRequestDispatcher("/views/user/order_history.jsp").forward(request, response);
    }
}

