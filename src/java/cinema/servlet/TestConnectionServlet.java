package cinema.servlet;

import cinema.connection.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/test-connection")
public class TestConnectionServlet extends HttpServlet {

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        Connection connection = DbConnection.getConnection();

        if (connection != null) {
            response.getWriter().println("<script>alert('Database connection established successfully!');</script>");
        } else {
            response.getWriter().println("<script>alert('Failed to establish database connection!');</script>");
        }
    }
}
