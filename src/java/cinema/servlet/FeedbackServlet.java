package cinema.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import cinema.connection.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form data
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String movieRating = request.getParameter("movieRating");
            String storylineRating = request.getParameter("storylineRating");
            String cinematographyRating = request.getParameter("cinematographyRating");
            String cleanliness = request.getParameter("cleanliness");
            String comfort = request.getParameter("comfort");
            String soundQuality = request.getParameter("soundQuality");
            String otherfeedback=request.getParameter("otherfeedback");

            // Get database connection and insert data
            Connection conn = DbConnection.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO feedback (name, phone, email, movie_rating, "
                        + "storyline_rating, cinematography_rating, cleanliness, "
                        + "comfort, sound_quality, other_feedback) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?)";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, name);
                    stmt.setString(2, phone);
                    stmt.setString(3, email);
                    stmt.setString(4, movieRating);
                    stmt.setString(5, storylineRating);
                    stmt.setString(6, cinematographyRating);
                    stmt.setString(7, cleanliness);
                    stmt.setString(8, comfort);
                    stmt.setString(9, soundQuality);
                    stmt.setString(10, otherfeedback);

                    stmt.executeUpdate();
                }

                // Redirect to feedback overview page
                response.sendRedirect("index.jsp");
            } else {
                response.getWriter().println("Error: Database connection failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
