package services.order;

import models.CartDetails;
import models.Order;
import models.OrderDetails;
import repositories.cart.ICartRepository;
import repositories.cart_details.ICartDetailsRepository;
import repositories.order.IOrderRepository;
import repositories.order.OrderRepository;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderService implements IOrderService {

    private final IOrderRepository orderRepository;
    private final ICartRepository cartRepository;
    private final ICartDetailsRepository cartDetailsRepository;

    public OrderService(ICartRepository cartRepository, ICartDetailsRepository cartDetailsRepository) {
        this.cartRepository = cartRepository;
        this.cartDetailsRepository = cartDetailsRepository;
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
    public boolean checkout(int userId, List<CartDetails> cartItems) {
        if (cartItems.isEmpty()) return false;

        int orderId = orderRepository.createOrder(userId, new Date(), "Đã đặt hàng");
        if (orderId <= 0) return false;

        List<OrderDetails> detailsList = new ArrayList<>();
        for (CartDetails item : cartItems) {
            OrderDetails detail = new OrderDetails();
            detail.setOrderId(orderId);
            detail.setBookId(item.getBookId());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getBook().getPrice());
            detailsList.add(detail);
        }

        orderRepository.saveOrderDetails(orderId, detailsList);
        cartDetailsRepository.clearCart(userId);
        return true;
    }

    @Override
    public List<Order> getOrderHistory(int userId) {
        return orderRepository.getOrdersByUser(userId);
    }
}