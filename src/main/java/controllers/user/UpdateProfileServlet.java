package controllers.user;

import models.User;
import services.user.IUserService;
import services.user.UserService;
import utils.CloudinaryUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-profile")
@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {
    private final IUserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // lay du lieu
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // validate
        if (name == null || name.trim().isEmpty() ||
                phone == null || !phone.matches("\\d{10,15}") ||
                address == null || address.trim().isEmpty()) {
            response.sendRedirect("views/user/profile.jsp?error=1");
            return;
        }

        // update thong tin
        user.setName(name);
        user.setPhoneNumber(phone);
        user.setAddress(address);

        // upload anh avatar
        Part avatarPart = request.getPart("avatar");
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String avatarUrl = CloudinaryUtil.uploadFile(avatarPart.getInputStream(), avatarPart.getSubmittedFileName());
            user.setAvatarUrl(avatarUrl);
        }

        boolean success = userService.updateUser(user);
        if (success) {
            session.setAttribute("user", user);
            response.sendRedirect("views/user/profile.jsp?success=1");
        } else {
            response.sendRedirect("views/user/profile.jsp?error=1");
        }
    }
}