package controllers.admin;

import models.Book;
import models.Category;
import services.book.BookService;
import services.book.IBookService;
import services.category.CategoryService;
import services.category.ICategoryService;
import utils.CloudinaryUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@WebServlet("/admin/books")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,   // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class AdminBookServlet extends HttpServlet {
    private final IBookService bookService = new BookService();
    private final ICategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                List<Category> categoriesAdd = categoryService.getAll();
                req.setAttribute("categories", categoriesAdd);
                req.getRequestDispatcher("/views/admin/book_form.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Book book = bookService.getBookById(id);
                List<Category> categoriesEdit = categoryService.getAll();
                req.setAttribute("book", book);
                req.setAttribute("categories", categoriesEdit);
                req.getRequestDispatcher("/views/admin/book_form.jsp").forward(req, resp);
                break;
            case "delete":
                int deleteId = Integer.parseInt(req.getParameter("id"));
                bookService.deleteBook(deleteId);
                req.getSession().setAttribute("toastMessage", "Xóa sách thành công!");
                resp.sendRedirect(req.getContextPath() + "/admin/books");
                break;
            case "search":
                String keyword = req.getParameter("keyword");
                List<Book> searchResults = bookService.searchBooksByKeyword(keyword);
                List<Category> allCategories = categoryService.getAll();

                Map<Integer, String> categoryMapSearch = new HashMap<>();
                for (Category category : allCategories) {
                    categoryMapSearch.put(category.getCategoryId(), category.getCategoryName());
                }

                req.setAttribute("books", searchResults);
                req.setAttribute("categoryMap", categoryMapSearch);
                req.setAttribute("searchKeyword", keyword); // để hiển thị lại keyword trong ô input
                req.getRequestDispatcher("/views/admin/book_list.jsp").forward(req, resp);
                break;

            default:
                List<Book> allBooks = bookService.getAllBooks();
                List<Category> categories = categoryService.getAll();

                // Tạo map từ categoryId -> categoryName
                Map<Integer, String> categoryMap = new HashMap<>();
                for (Category category : categories) {
                    categoryMap.put(category.getCategoryId(), category.getCategoryName());
                }

                // Lấy page hiện tại từ request param
                int booksPerPage = 5;
                int currentPage = 1;
                try {
                    currentPage = Integer.parseInt(req.getParameter("page"));
                } catch (NumberFormatException ignored) {
                }

                int totalBooks = allBooks.size();
                int totalPages = (int) Math.ceil((double) totalBooks / booksPerPage);

                // Tính chỉ số bắt đầu và kết thúc
                int startIndex = (currentPage - 1) * booksPerPage;
                int endIndex = Math.min(startIndex + booksPerPage, totalBooks);

                // Lấy danh sách sách theo trang
                List<Book> paginatedBooks = allBooks.subList(startIndex, endIndex);

                // Truyền dữ liệu sang JSP
                req.setAttribute("books", paginatedBooks); // chỉ sách cần hiển thị
                req.setAttribute("totalBooks", totalBooks);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("currentPage", currentPage);
                req.setAttribute("categoryMap", categoryMap);

                req.getRequestDispatcher("/views/admin/book_list.jsp").forward(req, resp);
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        
        if ("clearToastMessage".equals(action)) {
            req.getSession().removeAttribute("toastMessage");
            resp.setStatus(HttpServletResponse.SC_OK);
            return;
        }
        
        if ("delete".equals(action)) {
            int deleteId = Integer.parseInt(req.getParameter("id"));
            bookService.deleteBook(deleteId);
            req.getSession().setAttribute("toastMessage", "Xóa sách thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/books");
        } else {
            int maSach = req.getParameter("ma_sach") != null && !req.getParameter("ma_sach").isEmpty()
                    ? Integer.parseInt(req.getParameter("ma_sach")) : 0;

            String tenSach = req.getParameter("ten_sach");
            String tacGia = req.getParameter("tac_gia");
            String nhaXuatBan = req.getParameter("nha_xuat_ban");
            double gia = Double.parseDouble(req.getParameter("gia"));
            String moTa = req.getParameter("mo_ta");
            int maDanhMuc = Integer.parseInt(req.getParameter("ma_danh_muc"));
            int namXuatBan = Integer.parseInt(req.getParameter("nam_xuat_ban"));

            // Handle image upload
            Part imgPart = req.getPart("img_url");
            String imgUrl = null;

            if (imgPart != null && imgPart.getSize() > 0) {
                try (InputStream is = imgPart.getInputStream()) {
                    String submittedFileName = imgPart.getSubmittedFileName();
                    imgUrl = CloudinaryUtil.uploadFile(is, submittedFileName);
                    System.out.println("Image uploaded successfully: " + imgUrl);
                } catch (Exception e) {
                    System.err.println("Image upload failed:");
                    e.printStackTrace();
                }
            } else if (maSach != 0) {
                // Retain the existing image URL if no new image is uploaded
                Book existingBook = bookService.getBookById(maSach);
                imgUrl = existingBook.getImgUrl();
            }

            Book book = new Book(maSach, tenSach, tacGia, nhaXuatBan, gia, moTa, maDanhMuc, imgUrl, namXuatBan);

            if (maSach == 0) {
                bookService.addBook(book);
                req.getSession().setAttribute("toastMessage", "Thêm sách thành công!");
            } else {
                bookService.updateBook(book);
                req.getSession().setAttribute("toastMessage", "Cập nhật sách thành công!");
            }

            resp.sendRedirect(req.getContextPath() + "/admin/books");
        }
    }
}
