package cinema.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Clear session
        request.getSession().removeAttribute("admin");
        request.getSession().removeAttribute("auth");
        request.getSession().invalidate();
        
        // Get the context path
        String contextPath = request.getContextPath();
        
        // Clear admin cookie
        Cookie adminCookie = new Cookie("admin_session", null);
        adminCookie.setMaxAge(0);
        adminCookie.setPath(contextPath.length() > 0 ? contextPath : "/");
        response.addCookie(adminCookie);
        
        // Clear user cookie
        Cookie userCookie = new Cookie("user_session", null);
        userCookie.setMaxAge(0);
        userCookie.setPath(contextPath.length() > 0 ? contextPath : "/");
        response.addCookie(userCookie);
        
        // Add a client-side JavaScript to ensure cookies are cleared
        response.setContentType("text/html");
        response.getWriter().print("<script>" +
            "document.cookie.split(';').forEach(function(c) { " +
            "  document.cookie = c.trim().split('=')[0] + '=;' + 'expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;'; " +
            "}); " +
            "window.location.href='Login.jsp';" +
            "</script>");
    }
}