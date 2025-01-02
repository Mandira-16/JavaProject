<%@page import="cinema.model.Movie"%>
<%@page import="cinema.dao.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>E-Ticket - Filmor</title>
        <style>
            body {
                background-color: #1a1a1a;
                color: #fff;
                font-family: Arial, sans-serif;
                padding: 10px;
            }

            .ticket-container {
                max-width: 400px;
                margin: 20px auto;
                background-color: #2b2b2b;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                overflow: hidden;
            }
            .movie-image-container {
                width: 200px; 
                height: 300px; 
                margin: 20px auto;
                border-radius: 10px; 
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4); 
                perspective: 1000px; 
            }

            .movie-image-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                transform: scale(1.1); 
            }

            .ticket-header {
                text-align: center;
                padding: 15px;
                border-bottom: 1px solid #3d3d3d;
            }

            .ticket-header h1 {
                margin: 0;
                color: yellow;
                font-size: 24px;
            }

            .ticket-header p {
                margin: 5px 0 0;
                color: #888;
            }

            .ticket-details {
                padding: 20px;
            }

            .detail-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 12px;
                padding-bottom: 8px;
                border-bottom: 1px solid #3d3d3d;
            }

            .detail-label {
                color: #888;
                font-weight: bold;
            }

            .detail-value {
                text-align: right;
            }

            .qr-placeholder {
                text-align: center;
                padding: 20px;
                background-color: #333;
                margin: 20px;
                border-radius: 5px;
            }

            .ticket-footer {
                text-align: center;
                padding: 20px;
                background-color: #222;
            }

            .button-group {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 15px;
            }

            button {
                background-color: yellow;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 10px;
                border: none;
                cursor: pointer;
                transition: opacity 0.3s;
            }

            button:hover {
                opacity: 0.9;
            }

            .error-message {
                padding: 20px;
                text-align: center;
            }

            .error-message h2 {
                color: #ff4444;
            }

            .error-message ul {
                list-style-type: none;
                padding: 0;
            }

            .error-message li {
                color: #ff6666;
                margin: 5px 0;
            }

            @media print {
                body {
                    background-color: white;
                    color: black;
                }

                .ticket-container {
                    box-shadow: none;
                }

                .button-group {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <%
            // Getting parameters 
            String movieName = request.getParameter("movieName");
            String movieId = request.getParameter("movieId");
            String showDate = request.getParameter("showDate");
            String showTime = request.getParameter("showTime");
            String hallName = request.getParameter("hallName");
            String selectedSeats = request.getParameter("selectedSeats");
            String totalCost = request.getParameter("totalCost");

            // Getting movie image
            Movie movie = null;
            if (movieId != null) {
                MovieDAO movieDAO = new MovieDAO();
                movie = movieDAO.getMovieById(Integer.parseInt(movieId));
            }

            // Generating booking reference like a barcode
            String bookingRef = "FLM" + System.currentTimeMillis();

            boolean hasError = (movieName == null || showDate == null || showTime == null
                    || hallName == null || selectedSeats == null || totalCost == null);
        %>

        <div class="ticket-container">
            <% if (hasError) {%>
            <div class="error-message">
                <h2>Error: Missing Ticket Information</h2>
                <p>The following information is missing:</p>
                <ul>
                    <%= movieName == null ? "<li>Movie name</li>" : ""%>
                    <%= showDate == null ? "<li>Show date</li>" : ""%>
                    <%= showTime == null ? "<li>Show time</li>" : ""%>
                    <%= hallName == null ? "<li>Hall name</li>" : ""%>
                    <%= selectedSeats == null ? "<li>Seat information</li>" : ""%>
                    <%= totalCost == null ? "<li>Cost information</li>" : ""%>
                </ul>
                <p>Please try booking again.</p>
                <button onclick="window.location.href = 'index.jsp'">Return to Movies</button>
            </div>
            <% } else {%>

            <div class="ticket-header">
                <h1>E-Ticket</h1>
            </div>

            <% if (movie != null && movie.getMovieImagePath() != null) {%>
            <div class="movie-image-container">
                <img src="<%= movie.getMovieImagePath()%>" alt="<%= movieName%>">
            </div>
            <% } else { %>  <%-- Placeholder if image not available --%>
            <div style="width:100%; height:100%; background-color: #333; display:flex; align-items:center; justify-content:center; color:#888;">
                Image Not Available
            </div>
            <% }%>

            <div class="ticket-details">
                <div class="detail-row">
                    <span class="detail-label">Movie</span>
                    <span class="detail-value"><%= movieName%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Date</span>
                    <span class="detail-value"><%= showDate%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Time</span>
                    <span class="detail-value"><%= showTime%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Hall</span>
                    <span class="detail-value"><%= hallName%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Seats</span>
                    <span class="detail-value"><%= selectedSeats%></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Total Amount</span>
                    <span class="detail-value">Rs. <%= totalCost%></span>
                </div>
            </div>

            <div class="qr-placeholder">
                <%= bookingRef%>
            </div>

            <div class="ticket-footer">
                <p>Please show this ticket at the entrance.</p>
                <div class="button-group">
                    <button onclick="window.location.href = 'index.jsp'">Back to Movies</button>
                    <button onclick="window.print()">Print Ticket</button>
                </div>
            </div>
            <% }%>
        </div>

        <script>
            // Prevent going back to payment page
            history.pushState(null, null, document.URL);
            window.addEventListener('popstate', function () {
                history.pushState(null, null, document.URL);
            });
        </script>
    </body>
</html>