package cinema.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cinema.connection.DbConnection;
import cinema.dao.UserDAO;
import cinema.model.User;

@WebServlet("/user-list")
public class userListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDAO userDAO = new UserDAO(DbConnection.getConnection());
            List<User> userList = userDAO.getAllUsers();
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("User_AP.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

