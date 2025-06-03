package controllers.user;


import models.Book;
import models.OrderDetails;
import services.book.BookService;
import services.book.IBookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/add-to-cart"})
public class AddToCartController extends HttpServlet {
    private final IBookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pId = req.getParameter("pid");
        Book book = bookService.getBookById(Integer.parseInt(pId));

        HttpSession session = req.getSession();
        Object object = session.getAttribute("cart"); // luu tam vào session
        if (object == null) {
            OrderDetails item = new OrderDetails();
            item.setBook(book);
            item.setQuantity(1);
        }
        super.doGet(req, resp);
    }
}
