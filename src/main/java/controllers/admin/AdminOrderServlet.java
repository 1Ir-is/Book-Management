package controllers.admin;

import repositories.cart.CartRepository;
import repositories.cart.ICartRepository;
import repositories.cart_details.CartDetailsRepository;
import repositories.cart_details.ICartDetailsRepository;
import services.order.IOrderService;
import services.order.OrderService;
import utils.JDBCUtils;
import utils.SMTPMailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "OrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

    private final IOrderService orderService;

    public AdminOrderServlet() throws SQLException {
        Connection connection = JDBCUtils.getConnection();
        ICartRepository cartRepository = new CartRepository(connection);
        ICartDetailsRepository cartDetailsRepository = new CartDetailsRepository(connection);
        this.orderService = new OrderService(cartRepository, cartDetailsRepository);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setAttribute("orders", orderService.getAllOrders());
        request.getRequestDispatcher("/views/admin/order_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        if ("true".equals(request.getParameter("clearToast"))) {
            request.getSession().removeAttribute("updateSuccess");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        boolean isUpdated = orderService.updateOrderStatus(orderId, newStatus);

        if (isUpdated) {
            request.getSession().setAttribute("updateSuccess", true);

            // Lấy thông tin người dùng và đơn hàng
            String userEmail = orderService.getUserEmailByOrderId(orderId);
            String orderDate = orderService.getOrderDateByOrderId(orderId);
            String customerName = orderService.getCustomerNameByOrderId(orderId);
            String productDetails = orderService.getProductDetailsByOrderId(orderId);
            String totalPrice = orderService.getTotalPriceByOrderId(orderId);
            String expectedDeliveryDate = orderService.calculateExpectedDeliveryDate(orderDate);

            // Tạo placeholder cho template
            Map<String, String> placeholders = new HashMap<>();
            placeholders.put("orderId", String.valueOf(orderId));
            placeholders.put("orderDate", orderDate);
            placeholders.put("customerName", customerName);
            placeholders.put("productDetails", productDetails);
            placeholders.put("totalPrice", totalPrice);
            placeholders.put("status", newStatus);
            placeholders.put("expectedDeliveryDate", expectedDeliveryDate);

            try {
                String subject;
                String template;

                if ("Đã giao hàng".equals(newStatus)) {
                    subject = "📦 Cập Nhật Trạng Thái Đơn Hàng #" + orderId;
                    template = "mails/order_status.html";
                } else if ("Hoàn thành".equals(newStatus)) {
                    subject = "🎉 Cảm ơn bạn đã ủng hộ đơn hàng #" + orderId;
                    template = "mails/thank_you.html";
                } else {
                    subject = null;
                    template = null;
                }

                if (subject != null && template != null) {
                    String html = SMTPMailUtil.loadHtmlTemplate(template, placeholders);
                    SMTPMailUtil.sendEmail(userEmail, subject, html);
                }

            } catch (Exception e) {
                e.printStackTrace();
                // Tùy chọn: Ghi log hoặc lưu thông báo lỗi vào session
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
