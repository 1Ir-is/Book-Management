package repositories.cart;

import models.Cart;

import java.sql.*;

public class CartRepository implements ICartRepository {
    private Connection connection;

    public CartRepository(Connection connection) {
        this.connection = connection;
    }


    @Override
    public Cart findByUserId(int userId) {
        String sql = "SELECT * FROM gio_hang WHERE ma_nguoi_dung = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Cart cart = new Cart();
                cart.setCartId(resultSet.getInt("ma_gio_hang"));
                cart.setUserId(resultSet.getInt("ma_nguoi_dung"));
                cart.setDateCreate(resultSet.getDate("ngay_tao"));
                return cart;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Cart createCart(int userId) {
        String sql = "INSERT INTO gio_hang (ngay_tao,ma_nguoi_dung) VALUES (?,?)";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setDate(1, new java.sql.Date(System.currentTimeMillis()));
            statement.setInt(2, userId);
            int rows = statement.executeUpdate();
            if (rows > 0) {
                ResultSet resultSet = statement.getGeneratedKeys();
                if (resultSet.next()) {
                    int cartId = resultSet.getInt(1);
                    Cart cart = new Cart();
                    cart.setCartId(cartId);
                    cart.setUserId(userId);
                    cart.setDateCreate(new java.sql.Date(System.currentTimeMillis()));
                    return cart;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

