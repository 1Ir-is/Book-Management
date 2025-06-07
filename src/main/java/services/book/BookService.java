package services.book;

import models.Book;
import repositories.book.BookRepository;
import repositories.book.IBookRepository;

import java.util.List;

public class BookService implements IBookService {
    private final IBookRepository bookRepository = new BookRepository();

    @Override
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    @Override
    public Book getBookById(int maSach) {
        return bookRepository.findById(maSach);
    }

    @Override
    public boolean addBook(Book book) {
        return bookRepository.save(book);
    }

    @Override
    public boolean updateBook(Book book) {
        return bookRepository.update(book);
    }

    @Override
    public boolean deleteBook(int maSach) {
        return bookRepository.delete(maSach);
    }

    @Override
    public List<Book> searchBooks(String keyword, int categoryId) {
        return bookRepository.searchBooks(keyword, categoryId);
    }

    @Override
    public int getTotalBooks() {
        return bookRepository.countBooks();
    }

}
