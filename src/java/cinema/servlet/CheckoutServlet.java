package cinema.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import cinema.connection.DbConnection;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int movieId = Integer.parseInt(request.getParameter("movie_id"));
        // Retrieve email from cookies
        String userEmail = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_session".equals(cookie.getName())) {
                    userEmail = cookie.getValue();
                    break;
                }
            }
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getConnection();
            int showId = Integer.parseInt(request.getParameter("show_id"));
            String selectedSeats = request.getParameter("selected_seats");

            // Fetch show details
            String showQuery = "SELECT ss.show_date, ss.show_time, ss.hall_id, "
                    + "m.movie_name, m.movie_ticket_price, h.hall_name "
                    + "FROM show_schedule ss "
                    + "JOIN movies m ON ss.movie_id = m.movie_id "
                    + "JOIN halls h ON ss.hall_id = h.hall_id "
                    + "WHERE ss.id = ?";
            stmt = conn.prepareStatement(showQuery);
            stmt.setInt(1, showId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String movieName = rs.getString("movie_name");
                String showDate = rs.getDate("show_date").toString();
                String showTime = rs.getString("show_time");
                String hallName = rs.getString("hall_name");
                int ticketPrice = rs.getInt("movie_ticket_price");

                String[] seatIds = selectedSeats.split(",");
                int totalSeats = seatIds.length;
                int totalCost = ticketPrice * totalSeats;

                // Prepare seat numbers
                stmt = conn.prepareStatement("SELECT seat_number FROM seats WHERE seat_id IN ("
                        + String.join(",", seatIds) + ")");
                ResultSet seatRs = stmt.executeQuery();

                StringBuilder seatNumbers = new StringBuilder();
                while (seatRs.next()) {
                    seatNumbers.append(seatRs.getString("seat_number")).append(", ");
                }
                String seatNumbersList = seatNumbers.toString().replaceAll(", $", "");

                // Set attributes for checkout page
                request.setAttribute("showId", showId);
                request.setAttribute("movieId", movieId);
                request.setAttribute("userEmail", userEmail);
                request.setAttribute("movieName", movieName);
                request.setAttribute("showDate", showDate);
                request.setAttribute("showTime", showTime);
                request.setAttribute("hallName", hallName);
                request.setAttribute("seatNumbers", seatNumbersList);
                request.setAttribute("totalSeats", totalSeats);
                request.setAttribute("ticketPrice", ticketPrice);
                request.setAttribute("totalCost", totalCost);
                request.setAttribute("selectedSeatsId", selectedSeats);

                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error processing checkout: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
