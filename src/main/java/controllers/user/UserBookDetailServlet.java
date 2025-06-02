package controllers.user;

import models.Book;
import models.Category;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/book-detail")
public class UserBookDetailServlet  extends HttpServlet {
    private final IBookService bookService = new BookService();
    private final ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bookId = Integer.parseInt(req.getParameter("id"));

        Book book = bookService.getBookById(bookId);
        List<Category> categories = categoryService.getAll();

        // Cách viết map rõ ràng, dễ hiểu
        Map<Integer, String> categoryMap = new HashMap<>();
        for (Category category : categories) {
            int id = category.getCategoryId();
            String name = category.getCategoryName();
            categoryMap.put(id, name);
        }

        req.setAttribute("book", book);
        req.setAttribute("categoryMap", categoryMap);

        req.getRequestDispatcher("views/user/book_detail.jsp").forward(req, resp);
    }
}
