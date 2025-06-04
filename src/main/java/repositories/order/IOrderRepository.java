package repositories.order;

import models.Order;

import java.util.List;

public interface IOrderRepository {
    int createOrder(Order order);
    List<Order> getOrdersByUserId(int userId);
}
