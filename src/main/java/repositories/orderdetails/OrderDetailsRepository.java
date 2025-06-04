package repositories.orderdetails;

import models.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailsRepository implements IOrderDetailsRepository {
    private Connection conn;

    public OrderDetailsRepository(Connection conn) {
        this.conn = conn;
    }
    @Override
    public void addOrderDetails(List<OrderDetail> details) {
        String sql = "INSERT INTO chi_tiet_don_hang (ma_don_hang, ma_sach, so_luong, gia) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (OrderDetail detail : details) {
                stmt.setInt(1, detail.getOrderId());
                stmt.setInt(2, detail.getBookId());
                stmt.setInt(3, detail.getQuantity());
                stmt.setDouble(4, detail.getPrice());
                stmt.addBatch();
            }
            stmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderDetail> getDetailsByOrderId(int orderId) {
        return new ArrayList<>();

    }
}
