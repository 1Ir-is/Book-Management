package services.order;

import models.CartDetails;
import models.Order;
import java.util.List;

public interface IOrderService {
    List<Object[]> getAllOrders();
    List<Object[]> getOrderDetailsByOrderId(int orderId);
    List<Order> getOrderHistory(int userId);
    boolean updateOrderStatus(int orderId, String status);
    boolean checkout(int userId, List<CartDetails> cartItems);
    String getUserEmailByOrderId(int orderId);
    String getOrderDateByOrderId(int orderId);
    String getCustomerNameByOrderId(int orderId);
    String getProductDetailsByOrderId(int orderId);
    String getTotalPriceByOrderId(int orderId);
    String calculateExpectedDeliveryDate(String orderDate);
}