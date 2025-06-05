package controllers.user;

import models.Book;
import services.book.BookService;
import services.book.IBookService;
import services.category.CategoryService;
import services.category.ICategoryService;

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
    private final ICategoryService categoryService = new CategoryService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        List<Book> books = bookService.getAllBooks(); // Lấy tất cả sách từ DB
//        req.setAttribute("books", books);
//        req.getRequestDispatcher("views/user/book_list.jsp").forward(req, resp);
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String keyword = req.getParameter("keyword");
        String categoryIdStr = req.getParameter("category");

        int categoryId = -1;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                categoryId = -1;
            }
        }

        List<Book> books;
        if ((keyword != null && !keyword.trim().isEmpty()) || categoryId > 0) {
            books = bookService.searchBooks(keyword, categoryId);
        } else {
            books = bookService.getAllBooks();
        }

        req.setAttribute("books", books);
        req.setAttribute("keyword", keyword);
        req.setAttribute("category", categoryIdStr);
        req.setAttribute("categories", categoryService.getAll());

        req.getRequestDispatcher("views/user/book_list.jsp").forward(req, resp);
    }

}

