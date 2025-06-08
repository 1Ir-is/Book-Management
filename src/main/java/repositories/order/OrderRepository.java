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
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM don_hang WHERE ma_nguoi_dung = ? ORDER BY ngay_dat DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("ma_don_hang"));
                o.setUserId(rs.getInt("ma_nguoi_dung"));
                o.setOrderDate(rs.getDate("ngay_dat").toLocalDate());
                o.setStatus(rs.getString("trang_thai"));
//                o.setTotalAmount(rs.getDouble("total_amount")); // nếu có
                orders.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
