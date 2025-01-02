package cinema.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cinema.connection.DbConnection;
import cinema.dao.UserDAO;
import cinema.model.User;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Check for admin credentials
            if ("admin".equals(email) && "admin1".equals(password)) {
                // Create admin session
                String contextPath = request.getContextPath();
                Cookie adminCookie = new Cookie("admin_session", "admin");
                adminCookie.setMaxAge(24 * 60 * 60); // 1 day
                adminCookie.setPath(contextPath.length() > 0 ? contextPath : "/");
                response.addCookie(adminCookie);
                response.sendRedirect("addMovie.jsp");
                return;
            }

            // Regular user login
            UserDAO udao = new UserDAO(DbConnection.getConnection());
            User user = udao.loginUser(email, password);

            if (user != null) {
                String userName = user.getEmail();

                if (userName != null && !userName.isEmpty()) {
                    // Create user session
                    Cookie sessionCookie = new Cookie("user_session", userName);
                    sessionCookie.setMaxAge(60 * 60);
                    response.addCookie(sessionCookie);

                    // Save user object in session
                    request.getSession().setAttribute("auth", user);
                    request.getSession().setAttribute("admin", "false"); // Explicitly set non-admin

                    response.sendRedirect("index.jsp");
                } else {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Full name is missing!');");
                    out.println("window.location='Login.jsp';");
                    out.println("</script>");
                }
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Failed to log in. Please try again.');");
                out.println("window.location='Login.jsp';");
                out.println("</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('An error occurred. Please try again later.');");
                out.println("window.location='Login.jsp';");
                out.println("</script>");
            }
        }
    }
}
