package services.order;

import models.CartDetails;
import models.OrderDetails;
import repositories.order.IOrderRepository;
import repositories.order.OrderRepository;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
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
    public boolean checkout(int userId, List<CartDetails> cartDetails) {
        int orderId = orderRepository.createOrder(userId, new Date(), "Đang xử lý");
        List<OrderDetails> detailsList = new ArrayList<>();
        for (CartDetails details : cartDetails) {
            OrderDetails orderDetails = new OrderDetails();
            orderDetails.setBookId(details.getBookId());
            orderDetails.setQuantity(details.getQuantity());
            orderDetails.setPrice(details.getBook().getPrice());
            detailsList.add(orderDetails);
        }
        orderRepository.saveOrderDetails(orderId, detailsList);
        return true;
    }

    @Override
    public List<Object[]> getOrderDetailsByOrderId(int orderId) {
        return orderRepository.getOrderDetailsByOrderId(orderId);
    }

    @Override
    public List<Object[]> getOrdersByUser(int userId, int page, int pageSize) {
        return orderRepository.getOrdersByUser(userId, page, pageSize);
    }

    public int countOrdersByUser(int userId) {
        return orderRepository.countOrdersByUser(userId);
    }

    @Override
    public List<Object[]> getOrderDetails(int orderId, int userId) {
        return orderRepository.getOrderDetails(orderId, userId);
    }


}
