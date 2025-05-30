package repositories.book;

import models.Book;

import java.util.List;

public interface IBookRepository {
    List<Book> findAll();
    Book findById(int maSach);
    boolean save(Book book);
    boolean update(Book book);
    boolean delete(int maSach);
}
