package repositories.order;

import models.Order;
import models.OrderDetails;

import java.util.Date;
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

    int createOrder(int userId, Date date, String status);

    void saveOrderDetails(int orderId, List<OrderDetails> orderDetails);

    List<Object[]> getOrdersByUser(int userId, int page, int pageSize);
    List<Object[]> getOrderDetails(int orderId, int userId);
    int countOrdersByUser(int userId);
}