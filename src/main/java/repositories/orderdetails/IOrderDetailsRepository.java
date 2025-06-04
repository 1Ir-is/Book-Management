package repositories.orderdetails;

import models.OrderDetail;

import java.util.List;

public interface IOrderDetailsRepository {
    void addOrderDetails(List<OrderDetail> details);
    List<OrderDetail> getDetailsByOrderId(int orderId);
}
