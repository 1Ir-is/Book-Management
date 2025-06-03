package services.cart;

import models.CartDetails;

import java.util.List;

public interface ICartService {
    void addBookToCart(int userId, int bookId, int quantity);
    List<CartDetails> getListInCart(int userId);
}
