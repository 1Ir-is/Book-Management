package controllers.user;

import models.Book;
import services.book.BookService;
import services.book.IBookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
@WebServlet("/books")
public class UserBookListServlet extends HttpServlet {
    private final IBookService bookService = new BookService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> books = bookService.getAllBooks(); // Lấy tất cả sách từ DB
        req.setAttribute("books", books);
        req.getRequestDispatcher("views/user/book_list.jsp").forward(req, resp);
    }
}

