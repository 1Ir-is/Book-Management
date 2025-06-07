package services.book;

import models.Book;

import java.util.List;

public interface IBookService {
    List<Book> getAllBooks();
    List<Book> searchBooks(String keyword, int categoryId);
    Book getBookById(int maSach);
    boolean addBook(Book book);
    boolean updateBook(Book book);
    boolean deleteBook(int maSach);
    int getTotalBooks();
}
