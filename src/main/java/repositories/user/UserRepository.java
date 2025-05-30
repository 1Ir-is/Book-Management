package repositories.user;

import models.User;
import utils.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRepository implements IUserRepository {

    @Override
    public User findByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ? AND mat_khau = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("ma_nguoi_dung"));
                user.setName(resultSet.getString("ten"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("mat_khau"));
                user.setPhoneNumber(resultSet.getString("so_dien_thoai"));
                user.setAddress(resultSet.getString("dia_chi"));
                user.setRoleId(resultSet.getInt("ma_vai_tro"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ?";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("ma_nguoi_dung"));
                user.setName(resultSet.getString("ten"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("mat_khau"));
                user.setPhoneNumber(resultSet.getString("so_dien_thoai"));
                user.setAddress(resultSet.getString("dia_chi"));
                user.setRoleId(resultSet.getInt("ma_vai_tro"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean save(User user) {
        String sql = "INSERT INTO nguoi_dung (ten, email, mat_khau, so_dien_thoai, dia_chi, ma_vai_tro) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = JDBCUtils.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getPhoneNumber());
            preparedStatement.setString(5, user.getAddress());
            preparedStatement.setInt(6, user.getRoleId());
            int rows = preparedStatement.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
