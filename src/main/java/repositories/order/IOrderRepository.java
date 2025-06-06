package repositories.order;

import models.Order;
import java.util.List;

public interface IOrderRepository {
    List<Object[]> findAllOrder();
    List<Object[]> getOrderDetailsByOrderId(int orderId);
    boolean updateOrderStatus(int orderId, String status);
    String getUserEmailByOrderId(int orderId);
    String getOrderDateByOrderId(int orderId);
    String getCustomerNameByOrderId(int orderId);
    String getProductDetailsByOrderId(int orderId);
    String getTotalPriceByOrderId(int orderId);
}