package controllers.user;

import models.Category;
import models.User;
import services.category.CategoryService;
import services.category.ICategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("")
public class HomeServlet extends HttpServlet {
    private final ICategoryService categoryService = new CategoryService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null && user.getRoleId() == 0) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }


        List<Category> categories = categoryService.getAll();
        req.setAttribute("categories", categories);

        req.getRequestDispatcher("/views/user/home.jsp").forward(req, resp);
    }
}
