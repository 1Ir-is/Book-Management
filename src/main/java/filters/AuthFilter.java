package filters;

import models.User;
import services.user.UserService;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        boolean isPublic = uri.equals(req.getContextPath() + "/") ||
                uri.endsWith("/login") ||
                uri.endsWith("/register") ||
                uri.endsWith("/books") ||
                uri.endsWith("/book-detail") ||
                uri.endsWith("/contact-admin") ||
                uri.contains("/css") || uri.contains("/js") ||
                uri.endsWith(".png") || uri.endsWith(".jpg") ||
                uri.endsWith("/access-denied");


        // tu dong dang nhap bang cookie neu co session
        if (user == null && !isPublic) {
            String email = null, password = null;
            Cookie[] cookies = req.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("email")) {
                        email = cookie.getValue();
                    } else if (cookie.getName().equals("password")) {
                        password = cookie.getValue();
                    }
                }
            }
            if (email != null && password != null) {
                UserService userService = new UserService();
                user = userService.login(email, password);
                if (user != null) {
                    session = req.getSession();
                    session.setAttribute("user", user);
                    session.setMaxInactiveInterval(30 * 60); // 30 phut
                }
            }
        }

        // chan truy cap neu chua login
        if (user == null && !isPublic) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // phan quyen
        if (uri.startsWith(req.getContextPath() + "/admin")) {
            if (user == null || user.getRoleId() != 0) {
                resp.sendRedirect(req.getContextPath() + "/access-denied");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
