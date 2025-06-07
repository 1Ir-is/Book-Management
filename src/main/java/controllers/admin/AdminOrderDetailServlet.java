package controllers.admin;

import services.order.IOrderService;
import services.order.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/admin/order_detail"})
public class AdminOrderDetailServlet extends HttpServlet {

    private final IOrderService orderService;

    public AdminOrderDetailServlet() {
        this.orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        request.setAttribute("orderDetails", orderService.getOrderDetailsByOrderId(orderId));

        // Fetch the customer's name
        String customerName = orderService.getCustomerNameByOrderId(orderId);
        request.setAttribute("customerName", customerName); // Set the customer's name as a request attribute

        request.getRequestDispatcher("/views/admin/order_detail.jsp").forward(request, response);
    }
}
