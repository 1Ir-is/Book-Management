package controllers.admin;

import repositories.cart.CartRepository;
import repositories.cart.ICartRepository;
import repositories.cart_details.CartDetailsRepository;
import repositories.cart_details.ICartDetailsRepository;
import services.order.IOrderService;
import services.order.OrderService;
import utils.JDBCUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/admin/order_detail"})
public class AdminOrderDetailServlet extends HttpServlet {

    private final IOrderService orderService;

    public AdminOrderDetailServlet() throws SQLException {
        Connection connection = JDBCUtils.getConnection();
        ICartRepository cartRepository = new CartRepository(connection);
        ICartDetailsRepository cartDetailsRepository = new CartDetailsRepository(connection);
        this.orderService = new OrderService(cartRepository, cartDetailsRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        request.setAttribute("orderDetails", orderService.getOrderDetailsByOrderId(orderId));
        request.setAttribute("customerName", orderService.getCustomerNameByOrderId(orderId));

        request.getRequestDispatcher("/views/admin/order_detail.jsp").forward(request, response);
    }
}
