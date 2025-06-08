package repositories.cart;

import models.Cart;

public interface ICartRepository {
    Cart findByUserId(int userId);

    Cart createCart(int userId);
}
