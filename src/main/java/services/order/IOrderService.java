package services.order;

import models.CartDetails;
import models.Order;
import java.util.List;

public interface IOrderService {
    List<Object[]> getAllOrders();
    List<Object[]> getOrderDetailsByOrderId(int orderId);
    boolean updateOrderStatus(int orderId, String status);
    String getUserEmailByOrderId(int orderId);
    String getOrderDateByOrderId(int orderId);
    String getCustomerNameByOrderId(int orderId);
    String getProductDetailsByOrderId(int orderId);
    String getTotalPriceByOrderId(int orderId);
    String calculateExpectedDeliveryDate(String orderDate);
    boolean checkout(int userId, List<CartDetails> cartDetails);
    List<Object[]> getOrdersByUser(int userId, int page, int pageSize);
    List<Object[]> getOrderDetails(int orderId, int userId);
}