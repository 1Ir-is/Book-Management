package models;

public class CartDetails {
    private int cartId;
    private int bookId;
    private int quantity;
    private Book book;

    public CartDetails() {
    }


    public CartDetails(int cartId, int bookId, int quantity, Book book) {
        this.cartId = cartId;
        this.bookId = bookId;
        this.quantity = quantity;
        this.book = book;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}
