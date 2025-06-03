package services.cart;

import models.Cart;
import models.CartDetails;
import repositories.cart.ICartRepository;
import repositories.cartdetails.ICartDetailsRepository;

import java.util.List;

public class CartService implements ICartService {
    private ICartRepository cartRepository;
    private ICartDetailsRepository cartDetailsRepository;

    public CartService(ICartRepository cartRepository, ICartDetailsRepository cartDetailsRepository) {
        this.cartRepository = cartRepository;
        this.cartDetailsRepository = cartDetailsRepository;
    }

    @Override
    public void addBookToCart(int userId, int bookId, int quantity) {
        Cart cart = cartRepository.findByUserId(userId);

        if (cart == null) {
            cart = cartRepository.createCart(userId);
        }
        if (cart!=null){
            cartDetailsRepository.addOrUpdate(cart.getCartId(),bookId,quantity);
        } else {
            throw  new RuntimeException("Không thể tạo hoặc lấy giỏ hàng");
        }

    }

    @Override
    public List<CartDetails> getListInCart(int userId) {

        Cart cart = cartRepository.findByUserId(userId);
        if (cart == null) return null;
        return cartDetailsRepository.getAllByCartId(cart.getCartId());
    }
}
