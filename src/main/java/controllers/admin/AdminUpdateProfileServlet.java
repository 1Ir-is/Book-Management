package controllers.admin;

import models.User;
import services.user.IUserService;
import services.user.UserService;
import utils.CloudinaryUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/update-profile")
@MultipartConfig
public class AdminUpdateProfileServlet extends HttpServlet {
    private final IUserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        user.setName(name);
        user.setPhoneNumber(phone);
        user.setAddress(address);

        Part avatarPart = request.getPart("avatar");
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String avatarUrl = CloudinaryUtil.uploadFile(avatarPart.getInputStream(), avatarPart.getSubmittedFileName());
            user.setAvatarUrl(avatarUrl);
        }

        boolean success = userService.updateUser(user);
        request.setAttribute("success", success);
        request.setAttribute("error", !success);

        // forward lại đúng controller xử lý view
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/profile.jsp");
        dispatcher.forward(request, response);
    }
}
