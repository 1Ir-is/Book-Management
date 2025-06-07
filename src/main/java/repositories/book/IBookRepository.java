package repositories.book;

import models.Book;

import java.util.List;

public interface IBookRepository {
    List<Book> findAll();
    List<Book> searchBooks(String keyword, int categoryId);
    Book findById(int maSach);
    int countBooks();
    boolean save(Book book);
    boolean update(Book book);
    boolean delete(int maSach);
}
