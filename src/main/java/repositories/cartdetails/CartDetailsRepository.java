package repositories.cartdetails;

import models.Book;
import models.CartDetails;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDetailsRepository implements ICartDetailsRepository {
    private Connection connection;

    public CartDetailsRepository(Connection connection) {
        this.connection = connection;
    }

    @Override
    public void addOrUpdate(int cartId, int bookId, int quantity) {
        String sqlCheck = "SELECT so_luong FROM chi_tiet_gio_hang WHERE ma_gio_hang = ? AND ma_sach = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(sqlCheck)) {
            checkStmt.setInt(1, cartId);
            checkStmt.setInt(2, bookId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                // Đã có -> cập nhật số lượng
                int currentQty = rs.getInt("so_luong");
                String sqlUpdate = "UPDATE chi_tiet_gio_hang SET so_luong = ? WHERE ma_gio_hang = ? AND ma_sach = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(sqlUpdate)) {
                    updateStmt.setInt(1, currentQty + quantity);
                    updateStmt.setInt(2, cartId);
                    updateStmt.setInt(3, bookId);
                    updateStmt.executeUpdate();
                }
            } else {
                // Chưa có -> thêm mới
                String sqlInsert = "INSERT INTO chi_tiet_gio_hang (ma_gio_hang, ma_sach, so_luong) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = connection.prepareStatement(sqlInsert)) {
                    insertStmt.setInt(1, cartId);
                    insertStmt.setInt(2, bookId);
                    insertStmt.setInt(3, quantity);
                    insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<CartDetails> findByCartId(int cartId) {
        List<CartDetails> list = new ArrayList<>();
        String sql = "SELECT * FROM chi_tiet_gio_hang WHERE ma_gio_hang = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CartDetails item = new CartDetails();
                item.setCartId(cartId);
                item.setBookId(rs.getInt("ma_sach"));
                item.setQuantity(rs.getInt("so_luong"));
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    @Override
    public List<CartDetails> getAllByCartId(int cartId) {
        List<CartDetails> items = new ArrayList<>();
        String sql = "SELECT c.*, s.ten_sach, s.img_url, s.gia " +
                "FROM chi_tiet_gio_hang c " +
                "JOIN sach s ON c.ma_sach = s.ma_sach " +
                "WHERE c.ma_gio_hang = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CartDetails item = new CartDetails();
                item.setCartId(rs.getInt("ma_gio_hang"));
                item.setBookId(rs.getInt("ma_sach"));
                item.setQuantity(rs.getInt("so_luong"));

                Book book = new Book();
                book.setBookId(rs.getInt("ma_sach"));
                book.setBookName(rs.getString("ten_sach"));
                book.setPrice(rs.getDouble("gia"));
                book.setImgUrl(rs.getString("img_url"));

                item.setBook(book);
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
}
