package services.cart;

import models.Cart;
import models.CartDetails;
import repositories.book.IBookRepository;
import repositories.cart.ICartRepository;
import repositories.cart_details.ICartDetailsRepository;

import java.util.List;

public class CartService implements ICartService {
    private ICartRepository cartRepository;
    private ICartDetailsRepository cartDetailsRepository;
    private IBookRepository bookRepository;

    public CartService() {
    }

    public CartService(ICartRepository cartRepository, ICartDetailsRepository cartDetailsRepository, IBookRepository bookRepository) {
        this.cartRepository = cartRepository;
        this.cartDetailsRepository = cartDetailsRepository;
        this.bookRepository = bookRepository;
    }

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
        if (cart != null) {
            cartDetailsRepository.addOrUpdate(cart.getCartId(), bookId, quantity);
        } else {
            throw new RuntimeException("Không thể tạo hoặc lấy giỏ hàng");
        }

    }

    @Override
    public List<CartDetails> getListInCart(int userId) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart == null) return null;

        List<CartDetails> items = cartDetailsRepository.getAllByCartId(cart.getCartId());
        for (CartDetails item : items) {
            item.setBook(bookRepository.findById(item.getBookId()));
        }
        return items;
    }

    @Override
    public void changeQuantity(int userId, int bookId, int delta) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart != null) {
            cartDetailsRepository.updateQuantity(cart.getCartId(), bookId, delta);
        }

    }

    @Override
    public void setQuantity(int userId, int bookId, int quantity) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart != null) {
            cartDetailsRepository.setQuantity(cart.getCartId(), bookId, quantity);
        }
    }

    @Override
    public void removeBook(int userId, int bookId) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart != null) {
            cartDetailsRepository.removeBook(cart.getCartId(), bookId);
        }
    }

    @Override
    public void updateQuantity(int userId, int bookId, int quantity) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart != null) {
            if (quantity > 0) {
                cartDetailsRepository.setQuantity(cart.getCartId(), bookId, quantity);
            } else {
                cartDetailsRepository.removeBook(cart.getCartId(), bookId);
            }
        }
    }

    @Override
    public void removeItems(Integer userId, List<Integer> bookIds) {
        Cart cart = cartRepository.findByUserId(userId);
        if (cart != null && bookIds != null && !bookIds.isEmpty()) {
            for (Integer bookId : bookIds) {
                cartDetailsRepository.removeBook(cart.getCartId(), bookId);
            }
        }
    }

}