package services.order;

import models.CartDetails;
import models.Order;
import models.OrderDetail;
import repositories.cart.ICartRepository;
import repositories.cartdetails.ICartDetailsRepository;
import repositories.order.IOrderRepository;
import repositories.orderdetails.IOrderDetailsRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class OrderService implements IOrderService {
    private IOrderRepository orderRepo;
    private IOrderDetailsRepository detailsRepo;
    private ICartRepository cartRepo;
    private ICartDetailsRepository cartDetailsRepo;

    public OrderService() {
    }

    public OrderService(IOrderRepository orderRepo, IOrderDetailsRepository detailsRepo,
                        ICartRepository cartRepo, ICartDetailsRepository cartDetailsRepo) {
        this.orderRepo = orderRepo;
        this.detailsRepo = detailsRepo;
        this.cartRepo = cartRepo;
        this.cartDetailsRepo = cartDetailsRepo;
    }

    @Override
    public boolean checkout(int userId, String[] selectedBookIds) {
        if (selectedBookIds == null || selectedBookIds.length == 0) return false;

        List<Integer> selectedIds = Arrays.stream(selectedBookIds)
                .map(Integer::parseInt)
                .collect(Collectors.toList());

        List<CartDetails> items = cartDetailsRepo.getCartDetailsByUserId(userId);
        if (items == null) items = new ArrayList<>();

        // Lọc ra các sách được chọn, đảm bảo book != null
        List<CartDetails> filteredItems = items.stream()
                .filter(item -> item.getBook() != null && selectedIds.contains(item.getBook().getBookId()))
                .collect(Collectors.toList());

        if (filteredItems.isEmpty()) return false;

        Order order = new Order();
        order.setUserId(userId);
        order.setOrderDate(LocalDate.now());
        order.setStatus("Đang xử lý");

        int orderId = orderRepo.createOrder(order);
        if (orderId <= 0) return false;

        List<OrderDetail> orderDetails = new ArrayList<>();
        for (CartDetails item : filteredItems) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderId(orderId);
            detail.setBookId(item.getBook().getBookId());
            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getBook().getPrice());
            orderDetails.add(detail);
        }

        detailsRepo.addOrderDetails(orderDetails);
        cartDetailsRepo.removeItems(userId, selectedIds);

        return true;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        return orderRepo.getOrdersByUserId(userId);
    }

    @Override
    public List<Order> getOrderHistory(int userId) {
        List<Order> orders = orderRepo.getOrdersByUserId(userId);
        if (orders == null) return new ArrayList<>();

        for (Order order : orders) {
            List<OrderDetail> details = detailsRepo.getDetailsByOrderId(order.getOrderId());
            order.setDetails(details);

            // Tính tổng tiền
            double total = 0;
            for (OrderDetail d : details) {
                total += d.getPrice() * d.getQuantity();
            }
            order.setTotal(total);
        }
        return orders;
    }
}

