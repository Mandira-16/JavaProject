<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, cinema.connection.DbConnection" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Show Schedule Details</title>
        <style>

            body {
                background-color: #000;
                color: black;
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
            }
            h1, h2 {
                text-align: center;
                color: #FFD700;
                font-size: 40px;
                margin: 10px 0;
                display: flex;
            }
            .details-container {
                text-align: center;
                background-color: rgba(255, 255, 255, 0.1);
                padding: 20px;
                border-radius: 15px;
                margin-bottom: 30px;
            }
            .seat-container {
                display: grid;
                grid-template-columns: repeat(8, 1fr);
                gap: 20px;
                justify-content: center;
                margin-bottom: 40px;
            }
            .seat {
                width: 65px;
                height: 75px;
                background-color: #fff;
                border-radius: 12px;
                display: flex;
                justify-content: center;
                align-items: center;
                cursor: pointer;
                box-shadow: 0 6px 10px rgba(0, 0, 0, 0.5);
                transition: background-color 0.3s ease, box-shadow 0.3s ease, transform 0.3s ease;
                color: #fff;
            }
            .seat.selected {
                background-color: #FFD700;
                box-shadow: 0 0 20px rgba(255, 215, 0, 0.8);
                color: black;
            }
            .seat.booked {
                background-color: #34495e;
                cursor: not-allowed;
                opacity: 0.6;
            }
            .seat:hover:not(.booked) {
                transform: scale(1.1);
            }
            .message {
                text-align: center;
                font-size: 18px;
                margin-top: 20px;
            }
            .success {
                color: #2ecc71;
            }
            .error {
                color: #e74c3c;
            }
            /* Parent element */
            .parent {
                text-align: center;
            }

            /* Centered button */
            #submit-btn {
                display: inline-block; /* Ensures the button respects text alignment */
                padding: 15px 30px;
                background-color: #2e8b57;
                color: #fff;
                font-size: 18px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 20px;
                transition: background-color 0.3s ease;
            }

            #submit-btn:hover {
                background-color: #1c6c3c;
            }
            h1 {
                font-size: 40px;
                margin: 40px 0;
                color: #FFD700;
            }
            .screen {
                width: 80%;
                height: 40px;
                background-color: #444;
                color: #fff;
                text-align: center;
                line-height: 40px;
                font-weight: bold;
                margin-bottom: 50px;
                border-radius: 15px;
            }

            .legend {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                color: white;
            }
            .legend span {
                margin: 0 10px;
                font-size: 14px;
            }
            .legend .available, .legend .reserved, .legend .selected {
                display: inline-block;
                width: 30px;
                height: 30px;
                margin-right: 5px;
            }
            .available {
                background-color: #fff;
            }
            .reserved {
                background-color: #34495e;
            }
            .selected {
                background-color: #FFD700;
            }
            .popup-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                justify-content: center;
                align-items: center;
            }
            .popup {
                background-color: #fff;
                color: #000;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                width: 350px;
            }
            .popup button {
                padding: 12px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 20px;
                background-color: #800000;
                color: #fff;
            }
            .popup button:hover {
                background-color: #6b0000;
            }
            .popup .cancel-btn {
                background-color: #aaa;
            }
            .popup .cancel-btn:hover {
                background-color: #888;
            }
        </style>
    </head>
    <body>
        <h1>Movie Seat Booking</h1>
        <div class="screen">THEATER SCREEN</div>

        <%
            String selectedDate = request.getParameter("selectedDate");
            String selectedTime = request.getParameter("selectedTime");
            int movieId = Integer.parseInt(request.getParameter("movieId"));
            String selectedSeats = request.getParameter("selected_seats");
            String statusMessage = "";

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            if (selectedDate != null && selectedTime != null) {
                try {
                    conn = DbConnection.getConnection();
                    if (conn == null) {
                        throw new SQLException("Database connection is null.");
                    }

                    conn.setAutoCommit(false); // Begin transaction

                    // Fetch show_id for the selected movie, date, and time
                    String query = "SELECT id FROM show_schedule WHERE movie_id = ? AND show_date = ? AND show_time = ?";
                    stmt = conn.prepareStatement(query);
                    stmt.setInt(1, movieId);
                    stmt.setDate(2, java.sql.Date.valueOf(selectedDate));
                    stmt.setString(3, selectedTime);

                    rs = stmt.executeQuery();
                    if (rs.next()) {
                        int showId = rs.getInt("id");

                        // If there are selected seats, process the reservation
                        if (selectedSeats != null && !selectedSeats.isEmpty()) {
                            String[] seatIds = selectedSeats.split(",");
                            boolean allSeatsReserved = true;

                            for (String seatId : seatIds) {
                                // Update seat as booked
                                String updateSeatQuery = "UPDATE seats SET is_booked = 1 WHERE seat_id = ? AND show_id = ?";
                                stmt = conn.prepareStatement(updateSeatQuery);
                                stmt.setInt(1, Integer.parseInt(seatId));
                                stmt.setInt(2, showId);
                                int rowsUpdated = stmt.executeUpdate();

                                if (rowsUpdated == 0) {
                                    allSeatsReserved = false;
                                    break;
                                }
                            }

                            if (allSeatsReserved) {
                                conn.commit(); // Commit the transaction
                                // Pass the necessary data to the confirmation page
                                request.setAttribute("showId", showId);
                                request.setAttribute("movieId", movieId);
                                request.setAttribute("selectedDate", selectedDate);
                                request.setAttribute("selectedTime", selectedTime);
                                request.setAttribute("selectedSeats", selectedSeats);
                                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                            } else {
                                conn.rollback(); // Rollback if any seat couldn't be booked
                                statusMessage = "<span class='error'>Error: Some seats could not be reserved. They may already be booked.</span>";
                            }
                        }

        %>
        <%--<div class="details-container">
            <h2>Show ID: <%= showId%></h2>
            <p>Movie ID: <%= movieId%></p>
            <p>Selected Date: <%= selectedDate%></p>
            <p>Selected Time: <%= selectedTime%></p> -->
        </div>--%>

        <!-- Seat Selection -->
        <form action="checkout" method="POST" id="seat-form">
            <input type="hidden" name="show_id" value="<%= showId%>">
            <input type="hidden" name="movie_id" value="<%= movieId%>">
            <input type="hidden" name="selected_seats" id="selected_seats">
            <div class="seat-container">
                <%
                    // Fetch and display available seats
                    String seatQuery = "SELECT seat_id, seat_number, is_booked FROM seats WHERE show_id = ?";
                    stmt = conn.prepareStatement(seatQuery);
                    stmt.setInt(1, showId);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        int seatId = rs.getInt("seat_id");
                        String seatNumber = rs.getString("seat_number");
                        boolean isBooked = rs.getBoolean("is_booked");

                        String seatClass = isBooked ? "seat booked" : "seat";
                %>
                <div class="<%= seatClass%>" data-seat-id="<%= seatId%>" data-seat-number="<%= seatNumber%>" onclick="toggleSeatSelection(this)">
                    <%= seatNumber%>
                </div>
                <%
                    }
                %>
            </div>
            <div class="legend">
                <span><div class="available"></div> Available</span>
                <span><div class="reserved"></div> Reserved</span>
                <span><div class="selected"></div> Selected</span>
            </div>

            <div class="parent">
                <button type="submit" id="submit-btn">Reserve Selected Seats</button>
            </div>
        </form>

        <div class="message">
            <%= statusMessage%>
        </div>

        <script>
            let selectedSeats = [];

            function toggleSeatSelection(seatElement) {
                if (seatElement.classList.contains('booked')) {
                    return;
                }

                const seatId = seatElement.getAttribute('data-seat-id');

                if (seatElement.classList.contains('selected')) {
                    seatElement.classList.remove('selected');
                    selectedSeats = selectedSeats.filter(id => id !== seatId);
                } else {
                    seatElement.classList.add('selected');
                    selectedSeats.push(seatId);
                }

                document.querySelector('input[name="selected_seats"]').value = selectedSeats.join(',');
            }

            document.getElementById('seat-form').onsubmit = function (event) {
                if (selectedSeats.length === 0) {
                    alert('Please select at least one seat.');
                    event.preventDefault();
                }
            };
        </script>
        <%
                    } else {
                        out.println("<p>No show found for the selected date and time.</p>");
                    }
                } catch (Exception e) {
                    if (conn != null) {
                        conn.rollback(); // Rollback in case of any error
                    }
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (stmt != null) try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (conn != null) try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>Please select a date and time before submitting.</p>");
            }
        %>
        <script src="countdown.js"></script>
    </body>
</html>
