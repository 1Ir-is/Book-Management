package services.book;

import models.Book;

import java.util.List;

public interface IBookService {
    List<Book> getAllBooks();
    Book getBookById(int maSach);
    boolean addBook(Book book);
    boolean updateBook(Book book);
    boolean deleteBook(int maSach);
    List<Book> searchBooks(String keyword, int categoryId);




}
