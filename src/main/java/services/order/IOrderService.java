package services.order;

import models.Order;

import java.util.List;

public interface IOrderService {
    boolean checkout(int userId, String[] selectedBookIds);
    List<Order> getOrdersByUserId(int userId);
    List<Order> getOrderHistory(int userId);

}
