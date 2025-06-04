package repositories.order;

import models.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepository implements IOrderRepository {
    private Connection conn;

    public OrderRepository(Connection conn) {
        this.conn = conn;
    }

    @Override
    public int createOrder(Order order) {
        String sql = "INSERT INTO don_hang (ma_nguoi_dung, ngay_dat, trang_thai) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            stmt.setDate(2, java.sql.Date.valueOf(order.getOrderDate()));
            stmt.setString(3, order.getStatus());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        return new ArrayList<>();
    }
}
