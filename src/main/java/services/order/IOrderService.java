package services.order;

public interface IOrderService {
    boolean checkout(int userId, String[] selectedBookIds);

}
