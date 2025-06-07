package controllers.admin;

import models.User;
import services.book.BookService;
import services.book.IBookService;
import services.order.IOrderService;
import services.order.OrderService;
import services.user.IUserService;
import services.user.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final IOrderService orderService = new OrderService();
    private final IUserService userService = new UserService();
    private final IBookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || user.getRoleId() != 0) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        int userGoal = 100;
        int bookGoal = 100;
        int orderGoal = 100;
        double revenueGoal = 100000.0;

        int userCount = userService.getTotalUsers();
        int bookCount = bookService.getTotalBooks();
        int orderCount = orderService.getTotalOrders();
        double totalRevenue = orderService.getTotalRevenue();

        req.setAttribute("totalUsers", userCount);
        req.setAttribute("totalBooks", bookCount);
        req.setAttribute("totalOrders", orderCount);
        req.setAttribute("totalRevenue", totalRevenue);

        req.setAttribute("userProgress", (int)((userCount * 100.0) / userGoal));
        req.setAttribute("bookProgress", (int)((bookCount * 100.0) / bookGoal));
        req.setAttribute("orderProgress", (int)((orderCount * 100.0) / orderGoal));
        req.setAttribute("revenueProgress", (int)((totalRevenue * 100.0) / revenueGoal));


        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }
}

