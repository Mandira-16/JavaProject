package cinema.servlet;

import cinema.connection.DbConnection;
import cinema.connection.EmailService;  
import cinema.dao.MovieDAO;
import cinema.model.Movie;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/UpdateSeats")
public class UpdateSeatsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateSeatsServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        PreparedStatement stmt = null;
        String paymentStatus = request.getParameter("paymentStatus");
        String userEmail = request.getParameter("email");  // Added email parameter

        try {
            // Validate payment status
            if (!"COMPLETED".equals(paymentStatus)) {
                LOGGER.warning("Payment not completed. Status: " + paymentStatus);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Payment not completed");
                return;
            }

            // Validate email
            if (userEmail == null || userEmail.trim().isEmpty()) {
                LOGGER.severe("Missing email parameter");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Email is required");
                return;
            }

            // Retrieve and validate all required parameters
            String[] requiredParams = {"showId", "movieId", "movieName", "showDate",
                "showTime", "hallName", "selectedSeatsId",
                "selectedSeats", "ticketPrice", "totalSeats", "totalCost"};

            for (String param : requiredParams) {
                if (request.getParameter(param) == null || request.getParameter(param).trim().isEmpty()) {
                    LOGGER.severe("Missing required parameter: " + param);
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                            "Missing required parameter: " + param);
                    return;
                }
            }

            // Parse parameters
            int showId = Integer.parseInt(request.getParameter("showId"));
            int movieId = Integer.parseInt(request.getParameter("movieId"));
            String movieName = request.getParameter("movieName");
            String showDate = request.getParameter("showDate");
            String showTime = request.getParameter("showTime");
            String hallName = request.getParameter("hallName");
            String selectedSeatsId = request.getParameter("selectedSeatsId");
            String selectedSeats = request.getParameter("selectedSeats");
            double ticketPrice = Double.parseDouble(request.getParameter("ticketPrice"));
            int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
            double totalCost = Double.parseDouble(request.getParameter("totalCost"));

            // Validate movie exists
            MovieDAO moviesDAO = new MovieDAO();
            Movie movie = moviesDAO.getMovieById(movieId);
            if (movie == null) {
                LOGGER.severe("Movie not found with ID: " + movieId);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
                return;
            }

            // Database operations
            conn = DbConnection.getConnection();
            if (conn == null) {
                LOGGER.severe("Failed to establish database connection");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Database connection failed");
                return;
            }

            conn.setAutoCommit(false);

            // Update seats
            String updateSeatQuery = "UPDATE `seats` SET `is_booked` = 1 WHERE `seat_id` = ? AND `show_id` = ?";
            String[] seatIds = selectedSeatsId.split(",");

            boolean allSeatsReserved = true;
            for (String seatId : seatIds) {
                stmt = conn.prepareStatement(updateSeatQuery);
                stmt.setInt(1, Integer.parseInt(seatId.trim()));
                stmt.setInt(2, showId);

                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated == 0) {
                    allSeatsReserved = false;
                    LOGGER.warning("Failed to reserve seat: " + seatId);
                    break;
                }
            }

            if (allSeatsReserved) {
                conn.commit();

                // Send confirmation email
                try {
                    String subject = "Your E-Ticket for " + movieName;
                    String body = buildEmailBody(movie, showDate, showTime, hallName, selectedSeats, totalCost);
                    EmailService.sendEmail(userEmail, subject, body);
                    LOGGER.info("Confirmation email sent to: " + userEmail);
                } catch (Exception emailException) {
                    LOGGER.log(Level.WARNING, "Failed to send confirmation email", emailException);
                    // Continue with booking process despite email failure
                }

                // Build redirect URL with encoded parameters
                StringBuilder redirectURL = new StringBuilder("FinalTicket.jsp?");
                redirectURL.append("movieName=").append(URLEncoder.encode(movieName, StandardCharsets.UTF_8))
                        .append("&movieId=").append(URLEncoder.encode(String.valueOf(movieId), StandardCharsets.UTF_8))
                        .append("&showDate=").append(URLEncoder.encode(showDate, StandardCharsets.UTF_8))
                        .append("&showTime=").append(URLEncoder.encode(showTime, StandardCharsets.UTF_8))
                        .append("&hallName=").append(URLEncoder.encode(hallName, StandardCharsets.UTF_8))
                        .append("&selectedSeats=").append(URLEncoder.encode(selectedSeats, StandardCharsets.UTF_8))
                        .append("&ticketPrice=").append(URLEncoder.encode(String.valueOf(ticketPrice), StandardCharsets.UTF_8))
                        .append("&totalSeats=").append(URLEncoder.encode(String.valueOf(totalSeats), StandardCharsets.UTF_8))
                        .append("&totalCost=").append(URLEncoder.encode(String.valueOf(totalCost), StandardCharsets.UTF_8));

                LOGGER.info("Booking successful. Redirecting to ticket page.");
                response.sendRedirect(redirectURL.toString());

            } else {
                conn.rollback();
                LOGGER.warning("Failed to reserve all seats. Rolling back transaction.");
                response.sendError(HttpServletResponse.SC_CONFLICT,
                        "Some seats are no longer available. Please try again.");
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid number format in parameters", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid number format in parameters: " + e.getMessage());

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error", e);
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error rolling back transaction", ex);
            }
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Database error: " + e.getMessage());

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "An unexpected error occurred: " + e.getMessage());

        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error closing database resources", e);
            }
        }
    }

    // Helper method to build email body
    private String buildEmailBody(Movie movie, String showDate, String showTime,
            String hallName, String selectedSeats, double totalCost) {
        return "<h1>Movie Ticket Confirmation</h1>"
                + "<p><b>Movie:</b> " + movie.getMovieName() + "</p>"
                + "<p><b>Date:</b> " + showDate + "</p>"
                + "<p><b>Time:</b> " + showTime + "</p>"
                + "<p><b>Hall:</b> " + hallName + "</p>"
                + "<p><b>Seats:</b> " + selectedSeats + "</p>"
                + "<p><b>Total Cost:</b> LKR " + totalCost + "</p>"
                +"<p>Your e-ticket has been successfully issued. For any further cancellations, modifications, or assistance, please feel free to contact us at our hotline: [011 234 5678].</p>"
                + "<p>Thank you for booking with us!</p>";
    }
}
