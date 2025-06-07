package repositories.order;

import models.Order;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderRepository implements IOrderRepository {

    private static final Logger LOGGER = Logger.getLogger(OrderRepository.class.getName());

    @Override
    public List<Object[]> findAllOrder() {
        List<Object[]> orders = new ArrayList<>();
        String sql = "SELECT dh.ma_don_hang, dh.ngay_dat, dh.trang_thai, nd.ten AS ten_nguoi_dung, nd.email, " +
                "GROUP_CONCAT(CONCAT(s.ten_sach, ' x ', ctdh.so_luong) SEPARATOR ', ') AS sach_va_so_luong, " +
                "SUM(ctdh.so_luong * ctdh.gia) AS tong_tien " +
                "FROM don_hang dh " +
                "JOIN nguoi_dung nd ON dh.ma_nguoi_dung = nd.ma_nguoi_dung " +
                "JOIN chi_tiet_don_hang ctdh ON dh.ma_don_hang = ctdh.ma_don_hang " +
                "JOIN sach s ON ctdh.ma_sach = s.ma_sach " +
                "GROUP BY dh.ma_don_hang, dh.ngay_dat, dh.trang_thai, nd.ten, nd.email";

        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Object[] orderData = new Object[7];
                orderData[0] = resultSet.getInt("ma_don_hang");       // 0 - Mã đơn
                orderData[1] = resultSet.getDate("ngay_dat");         // 1 - Ngày đặt
                orderData[2] = resultSet.getString("trang_thai");     // 2 - Trạng thái
                orderData[3] = resultSet.getString("ten_nguoi_dung"); // 3 - Tên người đặt
                orderData[4] = resultSet.getString("email");          // 4 - Email
                orderData[5] = resultSet.getString("sach_va_so_luong");// 5 - Sách
                orderData[6] = resultSet.getDouble("tong_tien");      // 6 - Tổng tiền
                orders.add(orderData);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching orders from database", e);
        }
        return orders;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE don_hang SET trang_thai = ? WHERE ma_don_hang = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, orderId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public String getUserEmailByOrderId(int orderId) {
        String sql = "SELECT nd.email FROM don_hang dh JOIN nguoi_dung nd ON dh.ma_nguoi_dung = nd.ma_nguoi_dung WHERE dh.ma_don_hang = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    @Override
    public String getOrderDateByOrderId(int orderId) {
        String sql = "SELECT ngay_dat FROM don_hang WHERE ma_don_hang = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getDate("ngay_dat").toString();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public String getCustomerNameByOrderId(int orderId) {
        String sql = "SELECT nd.ten FROM don_hang dh JOIN nguoi_dung nd ON dh.ma_nguoi_dung = nd.ma_nguoi_dung WHERE dh.ma_don_hang = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("ten");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public String getProductDetailsByOrderId(int orderId) {
        String sql = "SELECT GROUP_CONCAT(CONCAT(s.ten_sach, ' x ', ctdh.so_luong) SEPARATOR ', ') AS sach_va_so_luong " +
                "FROM chi_tiet_don_hang ctdh " +
                "JOIN sach s ON ctdh.ma_sach = s.ma_sach " +
                "WHERE ctdh.ma_don_hang = ? " +
                "GROUP BY ctdh.ma_don_hang";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("sach_va_so_luong");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public String getTotalPriceByOrderId(int orderId) {
        String sql = "SELECT SUM(ctdh.so_luong * ctdh.gia) AS tong_tien " +
                "FROM chi_tiet_don_hang ctdh " +
                "WHERE ctdh.ma_don_hang = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return String.valueOf(resultSet.getDouble("tong_tien"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Object[]> getOrderDetailsByOrderId(int orderId) {
        List<Object[]> details = new ArrayList<>();
        String sql = "SELECT s.ten_sach, ctdh.so_luong, ctdh.gia " +
                "FROM chi_tiet_don_hang ctdh " +
                "JOIN sach s ON ctdh.ma_sach = s.ma_sach " +
                "WHERE ctdh.ma_don_hang = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Object[] detail = new Object[3];
                detail[0] = resultSet.getString("ten_sach"); // Book Name
                detail[1] = resultSet.getInt("so_luong");   // Quantity
                detail[2] = resultSet.getDouble("gia");    // Price
                details.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }
}