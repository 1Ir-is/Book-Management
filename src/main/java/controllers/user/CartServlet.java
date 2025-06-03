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
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    private final IBookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pId = req.getParameter("pid");
        Book book = bookService.getBookById(Integer.parseInt(pId));

        HttpSession session = req.getSession();
        Object object = session.getAttribute("cart"); // luu tam vào session

        Map<Integer, OrderDetails> cart;
        if (object == null) {
            cart = new HashMap<>();
        } else {
            cart = (Map<Integer, OrderDetails>) object;
        }

        // kiểm tra xem đã có sản phẩm trong cart chưa
        OrderDetails item = cart.get(book.getBookId());
        if (item == null) {
            item = new OrderDetails();
            item.setBook(book);
            item.setQuantity(1);
            item.setPrice(book.getPrice());
        } else {
            item.setQuantity(item.getQuantity() + 1);
        }

        cart.put(book.getBookId(), item); // cập nhập vào map
        session.setAttribute("cart", cart);
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
