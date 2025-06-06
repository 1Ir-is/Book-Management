package controllers.admin;

import services.order.IOrderService;
import services.order.OrderService;
import utils.GmailServiceUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "OrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

    private final IOrderService orderService;

    public AdminOrderServlet() {
        this.orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
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

        // Update order status
        boolean isUpdated = orderService.updateOrderStatus(orderId, newStatus);

        if (isUpdated) {
            request.getSession().setAttribute("updateSuccess", true);

            // Get user email and order details
            String userEmail = orderService.getUserEmailByOrderId(orderId);
            String orderDate = orderService.getOrderDateByOrderId(orderId);
            String customerName = orderService.getCustomerNameByOrderId(orderId);
            String productDetails = orderService.getProductDetailsByOrderId(orderId);
            String totalPrice = orderService.getTotalPriceByOrderId(orderId);
            String expectedDeliveryDate = orderService.calculateExpectedDeliveryDate(orderDate);

            // Prepare email placeholders
            Map<String, String> placeholders = new HashMap<>();
            placeholders.put("orderId", String.valueOf(orderId));
            placeholders.put("orderDate", orderDate);
            placeholders.put("customerName", customerName);
            placeholders.put("productDetails", productDetails);
            placeholders.put("totalPrice", totalPrice);
            placeholders.put("status", newStatus);
            placeholders.put("expectedDeliveryDate", expectedDeliveryDate);

            try {
                if ("Đã giao hàng".equals(newStatus)) {
                    // Send email for "Đã giao hàng"
                    GmailServiceUtil.sendEmail(userEmail, "Cập Nhật Trạng Thái Đơn Hàng", "mails/order_status.html", placeholders);
                } else if ("Hoàn thành".equals(newStatus)) {
                    // Send email for "Hoàn thành"
                    GmailServiceUtil.sendEmail(userEmail, "Cảm ơn bạn đã ủng hộ", "mails/thank_you.html", placeholders);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}