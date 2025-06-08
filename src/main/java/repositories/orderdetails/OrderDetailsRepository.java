package repositories.orderdetails;

import models.Book;
import models.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, s.ten_sach, s.img_url FROM chi_tiet_don_hang od " +
                "JOIN sach s ON od.ma_sach = s.ma_sach WHERE ma_don_hang = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderId(rs.getInt("ma_don_hang"));
                detail.setBookId(rs.getInt("ma_sach"));
                detail.setQuantity(rs.getInt("so_luong"));
                detail.setPrice(rs.getDouble("gia"));

                Book book = new Book();
                book.setBookId(rs.getInt("ma_sach"));
                book.setBookName(rs.getString("ten_sach"));
                book.setImgUrl(rs.getString("img_url"));
                detail.setBook(book);

                list.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

