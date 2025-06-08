package services.orderdetail;

import models.OrderDetail;

import java.util.List;

public interface IOrderDetailService {
    void addOrderDetails(List<OrderDetail> details);
    List<OrderDetail> getDetailsByOrderId(int orderId);
}
