package controllers.admin;

import models.Category;
import services.category.CategoryService;
import services.category.ICategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {
    private final ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/views/admin/category_form.jsp").forward(req, resp);
                break;
            case "edit":
                int idEdit = Integer.parseInt(req.getParameter("id"));
                Category category = categoryService.getById(idEdit);
                req.setAttribute("category", category);
                req.getRequestDispatcher("/views/admin/category_form.jsp").forward(req, resp);
                break;
            case "delete":
                int idDelete = Integer.parseInt(req.getParameter("id"));
                categoryService.delete(idDelete);
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                break;
            default:
                List<Category> categories = categoryService.getAll();
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/views/admin/category_list.jsp").forward(req, resp);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idRaw = req.getParameter("ma_danh_muc");
        String name = req.getParameter("ten_danh_muc");

        Category category = new Category();
        category.setCategoryName(name);

        if (idRaw != null && !idRaw.isEmpty()) {
            category.setCategoryId(Integer.parseInt(idRaw));
            categoryService.update(category);
        } else {
            categoryService.add(category);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}
