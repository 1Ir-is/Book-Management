package repositories.cartdetails;

import models.CartDetails;

import java.util.List;

public interface ICartDetailsRepository {
    void addOrUpdate(int cartId, int bookId, int quantity);

    List<CartDetails> findByCartId(int cartId);

    List<CartDetails> getAllByCartId(int cartId);
}
