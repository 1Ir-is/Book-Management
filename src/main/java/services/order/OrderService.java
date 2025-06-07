package services.order;

import repositories.order.IOrderRepository;
import repositories.order.OrderRepository;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class OrderService implements IOrderService {

    private final IOrderRepository orderRepository;

    public OrderService() {
        this.orderRepository = new OrderRepository();
    }

    @Override
    public List<Object[]> getAllOrders() {
        return ((OrderRepository) orderRepository).findAllOrder();
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        return orderRepository.updateOrderStatus(orderId, status);
    }

    @Override
    public String getUserEmailByOrderId(int orderId) {
        return orderRepository.getUserEmailByOrderId(orderId);
    }

    @Override
    public String getOrderDateByOrderId(int orderId) {
        return orderRepository.getOrderDateByOrderId(orderId);
    }

    @Override
    public String getCustomerNameByOrderId(int orderId) {
        return orderRepository.getCustomerNameByOrderId(orderId);
    }

    @Override
    public String getProductDetailsByOrderId(int orderId) {
        return orderRepository.getProductDetailsByOrderId(orderId);
    }

    @Override
    public String getTotalPriceByOrderId(int orderId) {
        return orderRepository.getTotalPriceByOrderId(orderId);
    }

    @Override
    public String calculateExpectedDeliveryDate(String orderDate) {
        LocalDate date = LocalDate.parse(orderDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        LocalDate expectedDate = date.plusDays(5);
        return expectedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    @Override
    public List<Object[]> getOrderDetailsByOrderId(int orderId) {
        return orderRepository.getOrderDetailsByOrderId(orderId);
    }

    @Override
    public int getTotalOrders() {
        return orderRepository.countOrders();
    }

    @Override
    public double getTotalRevenue() {
        return orderRepository.sumTotalRevenue();
    }
    
}