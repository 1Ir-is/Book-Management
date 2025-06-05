package services.user;

import models.User;
import repositories.user.IUserRepository;
import repositories.user.UserRepository;

import java.util.List;

public class UserService implements IUserService {

    private final IUserRepository userRepository = new UserRepository();

    @Override
    public User login(String email, String password) {
        return userRepository.findByEmailAndPassword(email, password);
    }

    @Override
    public boolean register(User user) {
        if (isEmailExists(user.getEmail())) {
            return false;
        }
        return userRepository.save(user);
    }

    @Override
    public boolean isEmailExists(String email) {
        return userRepository.findByEmail(email) != null;
    }

    @Override
    public boolean updateUser(User user) {
        return userRepository.update(user);
    }

    @Override
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public boolean blockUser(int userId) {
        return userRepository.updateStatus(userId, false);
    }

    @Override
    public boolean unblockUser(int userId) {
        return userRepository.updateStatus(userId, true);
    }
}