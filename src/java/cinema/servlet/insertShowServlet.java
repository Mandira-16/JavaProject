package cinema.servlet;

import cinema.connection.DbConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/insertShowServlet")
public class insertShowServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int hallId = Integer.parseInt(request.getParameter("hallId"));
        LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
        String[] showTimes = request.getParameterValues("showTime");

        // Establish database connection
        try (Connection conn = DbConnection.getConnection()) {
            String sql = "INSERT INTO show_schedule (movie_id, hall_id, show_date, show_time) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                LocalDate currentDate = startDate;

                // Loop through the dates
                while (!currentDate.isAfter(endDate)) {
                    // Loop through the show times for the current date
                    for (String showTime : showTimes) {
                        pstmt.setInt(1, movieId);
                        pstmt.setInt(2, hallId);
                        pstmt.setDate(3, java.sql.Date.valueOf(currentDate));
                        pstmt.setString(4, showTime);
                        pstmt.executeUpdate();
                    }
                    currentDate = currentDate.plusDays(1); // Increment date
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error inserting data: " + e.getMessage());
            return;
        }

        // Send success message
        response.getWriter().write("Show schedule added successfully!");
        response.sendRedirect("Ticket_AP.jsp");
    }
}