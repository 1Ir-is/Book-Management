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
                try {
                    int idEdit = Integer.parseInt(req.getParameter("id"));
                    Category category = categoryService.getById(idEdit);
                    if (category != null) {
                        req.setAttribute("category", category);
                        req.getRequestDispatcher("/views/admin/category_form.jsp").forward(req, resp);
                    } else {
                        req.getSession().setAttribute("toastMessage", "Thể loại không tồn tại!");
                        resp.sendRedirect(req.getContextPath() + "/admin/categories");
                    }
                } catch (NumberFormatException e) {
                    req.getSession().setAttribute("toastMessage", "ID không hợp lệ!");
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                }
                break;
            case "delete":
                try {
                    int idDelete = Integer.parseInt(req.getParameter("id"));
                    Category categoryToDelete = categoryService.getById(idDelete);
                    if (categoryToDelete != null) {
                        categoryService.delete(idDelete);
                        req.getSession().setAttribute("toastMessage", "Xóa thể loại thành công!");
                    } else {
                        req.getSession().setAttribute("toastMessage", "Thể loại không tồn tại!");
                    }
                } catch (NumberFormatException e) {
                    req.getSession().setAttribute("toastMessage", "ID không hợp lệ!");
                }
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
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = categoryService.getById(id);
                if (category != null) {
                    categoryService.delete(id);
                    req.getSession().setAttribute("toastMessage", "Xóa thể loại thành công!");
                } else {
                    req.getSession().setAttribute("toastMessage", "Thể loại không tồn tại!");
                }
            } catch (NumberFormatException e) {
                req.getSession().setAttribute("toastMessage", "ID không hợp lệ!");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
            return;
        }

        // Xử lý thêm/sửa như cũ...
        String idRaw = req.getParameter("ma_danh_muc");
        String name = req.getParameter("ten_danh_muc");

        if (name == null || name.trim().isEmpty()) {
            req.getSession().setAttribute("toastMessage", "Tên thể loại không được để trống!");
            resp.sendRedirect(req.getContextPath() + "/admin/categories?action=add");
            return;
        }

        Category category = new Category();
        category.setCategoryName(name.trim());

        try {
            if (idRaw != null && !idRaw.isEmpty()) {
                category.setCategoryId(Integer.parseInt(idRaw));
                categoryService.update(category);
                req.getSession().setAttribute("toastMessage", "Cập nhật thể loại thành công!");
            } else {
                categoryService.add(category);
                req.getSession().setAttribute("toastMessage", "Thêm thể loại thành công!");
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("toastMessage", "ID không hợp lệ!");
        }

        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }

}