package services.user;

import models.User;

public interface IUserService {
    User login(String email, String password);
    boolean register(User user);
    boolean isEmailExists(String email);
}
