package services.order;

import models.Order;
import java.util.List;

public interface IOrderService {
    List<Object[]> getAllOrders();
    List<Object[]> getOrderDetailsByOrderId(int orderId);
    int getTotalOrders();
    double getTotalRevenue();
    boolean updateOrderStatus(int orderId, String status);
    String getUserEmailByOrderId(int orderId);
    String getOrderDateByOrderId(int orderId);
    String getCustomerNameByOrderId(int orderId);
    String getProductDetailsByOrderId(int orderId);
    String getTotalPriceByOrderId(int orderId);
    String calculateExpectedDeliveryDate(String orderDate);
}