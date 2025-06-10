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

        int booksPerPage = 12; // Number of books per page
        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(req.getParameter("page"));
        } catch (NumberFormatException ignored) {
        }

        List<Book> allBooks;
        if ((keyword != null && !keyword.trim().isEmpty()) || categoryId > 0) {
            allBooks = bookService.searchBooks(keyword, categoryId);
        } else {
            allBooks = bookService.getAllBooks();
        }

        int totalBooks = allBooks.size();
        int totalPages = (int) Math.ceil((double) totalBooks / booksPerPage);

        int startIndex = (currentPage - 1) * booksPerPage;
        int endIndex = Math.min(startIndex + booksPerPage, totalBooks);

        List<Book> paginatedBooks = allBooks.subList(startIndex, endIndex);

        req.setAttribute("books", paginatedBooks);
        req.setAttribute("totalBooks", totalBooks);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("keyword", keyword);
        req.setAttribute("category", categoryIdStr);
        req.setAttribute("categories", categoryService.getAll());

        req.getRequestDispatcher("views/user/book_list.jsp").forward(req, resp);
    }

}

