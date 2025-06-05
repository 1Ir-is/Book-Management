package repositories.user;

import models.User;

import java.util.List;

public interface IUserRepository {
    User findByEmailAndPassword(String email, String password);
    User findByEmail(String email);
    List<User> findAll();
    boolean save(User user);
    boolean update(User user);
    boolean updateStatus(int userId, boolean status);
}
