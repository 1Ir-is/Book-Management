package services.user;

import models.User;

import java.util.List;

public interface IUserService {
    User login(String email, String password);
    List<User> getAllUsers();
    boolean register(User user);
    boolean isEmailExists(String email);
    boolean updateUser(User user);
    boolean blockUser(int userId);
    boolean unblockUser(int userId);
}
