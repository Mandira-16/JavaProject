package cinema.servlet;

import java.io.IOException;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cinema.connection.DbConnection;
import cinema.dao.UserDAO;
import cinema.model.User;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve form parameters
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneno");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        // Validate input
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("Register_User.jsp").forward(request, response);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.getRequestDispatcher("Register_User.jsp").forward(request, response);
            return;
        }

        // Create user object
        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);

        // Perform registration
        try (Connection con = DbConnection.getConnection()) {
            UserDAO userDAO = new UserDAO(con);

            // Check if email already exists
            if (userDAO.isEmailExists(email)) {
                request.setAttribute("errorMessage", "Email already registered");
                request.getRequestDispatcher("Register_User.jsp").forward(request, response);
                return;
            }

            // Register user
            boolean isRegistered = userDAO.registerUser(user);
            if (isRegistered) {
                // Redirect to login with success message
                response.sendRedirect("Login.jsp?success=1");
            } else {
                request.setAttribute("errorMessage", "Registration failed");
                request.getRequestDispatcher("Register_User.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred");
            request.getRequestDispatcher("Register_User.jsp").forward(request, response);
        }
    }
}