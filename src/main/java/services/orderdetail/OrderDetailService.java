package services.orderdetail;

import models.OrderDetail;
import repositories.orderdetails.IOrderDetailsRepository;

import java.util.List;

public class OrderDetailService implements  IOrderDetailService {
    private IOrderDetailsRepository orderDetailsRepository;

    public OrderDetailService(IOrderDetailsRepository detailsRepository) {
        this.orderDetailsRepository = detailsRepository;
    }

    @Override
    public void addOrderDetails(List<OrderDetail> details) {
        orderDetailsRepository.addOrderDetails(details);
    }

    @Override
    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        return orderDetailsRepository.getDetailsByOrderId(orderId);
    }
}
