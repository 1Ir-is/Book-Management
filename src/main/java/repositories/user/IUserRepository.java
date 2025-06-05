package repositories.user;

import models.User;

public interface IUserRepository {
    User findByEmailAndPassword(String email, String password);
    User findByEmail(String email);
    boolean save(User user);
    boolean update(User user);
}
