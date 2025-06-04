package services.cart;

import models.CartDetails;

import java.util.List;

public interface ICartService {
    void addBookToCart(int userId, int bookId, int quantity);

    List<CartDetails> getListInCart(int userId);

    void changeQuantity(int userId, int bookId, int delta);

    void setQuantity(int userId, int bookId, int quantity);

    void removeBook(int userId, int bookId);

    void updateQuantity(int userId, int bookId, int quantity);

}
