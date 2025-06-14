package repositories.cart_details;

import models.CartDetails;

import java.util.List;

public interface ICartDetailsRepository {
    void addOrUpdate(int cartId, int bookId, int quantity);

    List<CartDetails> findByCartId(int cartId);

    List<CartDetails> getAllByCartId(int cartId);

    void updateQuantity(int cartId, int bookId, int delta);

    void setQuantity(int cartId, int bookId, int quantity);

    void removeBook(int cartId, int bookId);

    List<CartDetails> getCartDetailsByUserId(int userId);

    void clearCart(int userId);

    void removeItems(int userId, List<Integer> bookIds);

}
